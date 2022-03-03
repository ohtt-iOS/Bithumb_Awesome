//
//  HomeCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import ComposableArchitecture

struct HomeState: Equatable {
  var tickerData: [Ticker]
  var radioButtonState = RadioButtonState(buttons: [.koreanWon,
                                                    .bitcoin,
                                                    .interest,
                                                    .popularity],
                                          selectedButton: .koreanWon)
}

enum HomeAction: Equatable {
  case tickerResponse(Result<[Ticker], HomeService.Failure>)
  case radioButtonAction(RadioButtonAction)
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
      state.tickerData = response.sorted(by: { $0.ticker < $1.ticker})
      return .none
      
    case let .radioButtonAction(.buttonTap(type)):
      struct TickerId: Hashable {}
      print(type)
      switch type {
      case .koreanWon:
        return environment.homeService
          .getTickerData("ALL", "KRW")
          .receive(on: environment.mainQueue)
          .catchToEffect(HomeAction.tickerResponse)
          .cancellable(id: TickerId(), cancelInFlight: true)
      case .bitcoin:
        return environment.homeService
          .getTickerData("ALL", "BTC")
          .receive(on: environment.mainQueue)
          .catchToEffect(HomeAction.tickerResponse)
          .cancellable(id: TickerId(), cancelInFlight: true)
      case .interest:
        state.tickerData = []
        return .none
      case .popularity:
        return .none
      default:
        return .none
      }
    case .radioButtonAction:
      return .none
    }
  }
])
