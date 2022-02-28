//
//  HomeCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import ComposableArchitecture

struct HomeState: Equatable {
  var radioButtonState = RadioButtonState(buttons: [.koreanWon,
                                                    .bitcoin,
                                                    .interest,
                                                    .popularity],
                                          selectedButton: .koreanWon)
}

enum HomeAction: Equatable {
  case radioButtonAction(RadioButtonAction)
}

struct HomeEnvironment {
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
    case let .radioButtonAction(.buttonTap(type)):
      print(type)
      switch type {
      case .koreanWon:
        return .none
      case .bitcoin:
        return .none
      case .interest:
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
