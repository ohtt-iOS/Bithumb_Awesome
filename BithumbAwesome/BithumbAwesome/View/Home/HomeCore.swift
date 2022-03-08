//
//  HomeCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import ComposableArchitecture

struct HomeState: Equatable {
  var tickerData: [Ticker]
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
  case requestTickerData(String, String)
}

struct HomeEnvironment {
  var homeService: HomeService
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

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
      state.tickerData = []
      return .none
      
    case let .tickerResponse(.success(response)):
      if state.radioButtonState.selectedButton == .popularity {
        state.tickerData = response.sorted(by: { $0.data.accTradeValue24H ?? "" > $1.data.accTradeValue24H ?? "" } )
      } else {
        state.tickerData = response.sorted(by: { $0.ticker < $1.ticker})
      }
      return .none
      
    case let .requestTickerData(order, payment):
      struct TickerId: Hashable {}
      return environment.homeService
        .getTickerData(order, payment)
        .receive(on: environment.mainQueue)
        .catchToEffect(HomeAction.tickerResponse)
        .cancellable(id: TickerId(), cancelInFlight: true)
      
    case let .radioButtonAction(.buttonTap(type)):
      print(type)
      // 이전과 같은 request라면 요청하지 않는다.
      guard state.requestState != type else {
        return .none
      }
      
      state.requestState = type
      switch type {
      case .koreanWon:
        return Effect(value: .requestTickerData("ALL", "KRW"))
      case .bitcoin:
        return Effect(value: .requestTickerData("ALL", "BTC"))
      case .interest:
        state.tickerData = []
        return .none
      case .popularity:
        return Effect(value: .requestTickerData("ALL", "KRW"))
      default:
        return .none
      }
    case .radioButtonAction:
      return .none
    }
  }
])
