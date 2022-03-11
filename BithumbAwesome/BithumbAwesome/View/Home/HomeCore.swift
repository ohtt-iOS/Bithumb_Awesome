//
//  HomeCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import ComposableArchitecture
import Foundation

struct HomeState: Equatable {
  var filteredTickers = IdentifiedArrayOf<TickerState>()
  var socketIdDictionary: [String: UUID] = [:]
  var appearTicker: [String: Bool] = [:]
  var tickerData: [Ticker]
  var searchText: String = ""
  var requestState: AwesomeButtonType?
  var socketState: SocketState
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
  case tickerRow(id: UUID, action: TickerAction)
  case webSocket(SocketAction)
  
  case onRowAppear(String)
  case onRowDisappear(String)
}

struct HomeEnvironment {
  var homeService: HomeService
  var socketService: SocketService
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

struct TextFieldID: Hashable {}
struct TickerId: Hashable {}
struct SocketTikcerID: Hashable {}

let homeReducer = Reducer.combine(
  radioButtonReducer.pullback(
    state: \.radioButtonState,
    action: /HomeAction.radioButtonAction,
    environment: { _ in
      RadioButtonEnvironment()
    }
  ),
  socketReducer.pullback(
    state: \.socketState,
    action: /HomeAction.webSocket,
    environment: {
      SocketEnvironment(mainQueue: $0.mainQueue,
                        websocket: $0.socketService)
    }
  ),
  tickerReducer.forEach(
    state: \.filteredTickers,
    action: /HomeAction.tickerRow(id:action:),
    environment: {
      TickerEnvironment(mainQueue: $0.mainQueue)
    }
  ),
  Reducer<HomeState, HomeAction, HomeEnvironment> { state, action, environment in
    switch action {
    case .tickerResponse(.failure):
      state.filteredTickers = []
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
          state.filteredTickers = []
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
      state.filteredTickers = []
      state.socketIdDictionary = [:]
      let filterdData = (state.searchText != "") ? state.tickerData.filter { $0.name.contains(text) || $0.ticker.contains(text) } : state.tickerData
      var dictionary: [String: UUID] = [:]
      var tickers = IdentifiedArrayOf<TickerState>()
      for ticker in filterdData {
        let id = UUID()
        tickers.append(TickerState(id: id, ticker: ticker))
        dictionary[ticker.underScoreString] = id
      }
      state.socketIdDictionary = dictionary
      state.filteredTickers = tickers
      let keys = Array(state.socketIdDictionary.keys)
      return Effect(value: .webSocket(.sendFilter("ticker", keys, ["30M"])))
      
    case .tickerRow(id: let id, action: let action):
      return .none
    case let .webSocket(.getTicker(ticker)):
      guard let id = state.socketIdDictionary[ticker.underScoreString],
            let visable = state.appearTicker[ticker.underScoreString]
      else {
        return .none
      }
      return Effect(value: .tickerRow(id: id, action: .getTicker(ticker)))
    case .webSocket:
      return .none
      
    case let .onRowAppear(ticker):
      state.appearTicker[ticker] = true
      return .none
    case let .onRowDisappear(ticker):
      state.appearTicker[ticker] = nil
      return .none
    }
  }
)

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

