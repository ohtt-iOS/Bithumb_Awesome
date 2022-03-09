//
//  HomeCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import ComposableArchitecture

struct HomeState: Equatable {
  var tickerData: [Ticker]
  var filteredData: [Ticker]
  var searchText: String = ""
  var requestState: AwesomeButtonType?
  var radioButtonState = RadioButtonState(buttons: [.koreanWon,
                                                    .bitcoin,
                                                    .interest,
                                                    .popularity],
                                          selectedButton: .koreanWon)
}

enum HomeAction: Equatable {
  case tickerResponse(Result<[Ticker], HomeService.Failure>)
  case radioButtonAction(RadioButtonAction)
  case searchTextFieldChanged(String)
  case setFilteredData(String)
}

struct HomeEnvironment {
  var homeService: HomeService
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

struct TextFieldID: Hashable {}
struct TickerId: Hashable {}

let homeReducer = Reducer.combine([
  radioButtonReducer.pullback(
    state: \.radioButtonState,
    action: /HomeAction.radioButtonAction,
    environment: { _ in
      RadioButtonEnvironment()
    }
  ) as Reducer<HomeState, HomeAction, HomeEnvironment>,
  Reducer<HomeState, HomeAction, HomeEnvironment> { state, action, environment in
    switch action {
    case .tickerResponse(.failure):
      state.filteredData = []
      state.tickerData = []
      return .none
      
    case let .tickerResponse(.success(response)):
      switch state.radioButtonState.selectedButton {
      case .koreanWon, .bitcoin:
        state.tickerData = response.sorted(by: { $0.ticker < $1.ticker})
      case .interest:
        state.tickerData = response
      case .popularity:
        state.tickerData = response.sorted(by: { $0.accTradeValue24H ?? "" > $1.accTradeValue24H ?? "" } )
      default:
        return .none
      }
      return Effect(value: .setFilteredData(state.searchText))
      
    case let .radioButtonAction(.buttonTap(type)):
      print(type)
      // 이전과 같은 request라면 요청하지 않는다.
      guard state.requestState != type else {
        return .none
      }
      state.requestState = type
      switch type {
      case .koreanWon:
        return requestTickerData(environment: environment, order: "ALL", payment: "KRW")
      case .bitcoin:
        return requestTickerData(environment: environment, order: "ALL", payment: "BTC")
      case .interest:
        guard
          let favoriteList = UserDefaults.standard.array(
            forKey: UserDefaultsKey.favoriteList
          ) as? [String],
          !favoriteList.isEmpty
        else {
          state.filteredData = []
          state.tickerData = []
          return .none
        }
        return requestFavoriteData(environment: environment, underscope: favoriteList)
      case .popularity:
        return requestTickerData(environment: environment, order: "ALL", payment: "KRW")
      default:
        return .none
      }
      
    case .radioButtonAction:
      return .none
      
    case let .searchTextFieldChanged(text):
      return Effect(value: .setFilteredData(text))
        .debounce(id: TextFieldID(), for: 0.5, scheduler: environment.mainQueue)
      
    case let .setFilteredData(text):
      state.searchText = text
      if state.searchText != "" {
        state.filteredData = state.tickerData.filter { $0.name.contains(text) || $0.ticker.contains(text) }
      } else {
        state.filteredData = state.tickerData
      }
      return .none
    }
  }
])

private func requestTickerData(environment: HomeEnvironment,
                               order: String,
                               payment: String) -> Effect<HomeAction, Never> {
  return environment.homeService
    .getTickerData(order, payment)
    .receive(on: environment.mainQueue)
    .catchToEffect(HomeAction.tickerResponse)
    .cancellable(id: TickerId(), cancelInFlight: true)
}

private func requestFavoriteData(environment: HomeEnvironment,
                                 underscope: [String]) -> Effect<HomeAction, Never> {
  struct TickerId: Hashable {}
  return environment.homeService
    .getFavoriteData(underscope)
    .receive(on: environment.mainQueue)
    .catchToEffect(HomeAction.tickerResponse)
    .cancellable(id: TickerId(), cancelInFlight: true)
}
