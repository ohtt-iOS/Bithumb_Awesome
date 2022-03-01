//
//  DetailCore.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import ComposableArchitecture

struct DetailState: Equatable {
  var radioButtonState = RadioButtonState(buttons: [.chart,
                                                    .quote,
                                                    .conclusion],
                                          selectedButton: .chart)
}

enum DetailAction: Equatable {
  case radioButtonAction(RadioButtonAction)
}

struct DetailEnvironment {
}

let detailReducer = Reducer.combine([
  radioButtonReducer.pullback(
    state: \.radioButtonState,
    action: /DetailAction.radioButtonAction,
    environment: { _ in
      RadioButtonEnvironment()
    }
  ) as Reducer<DetailState, DetailAction, DetailEnvironment>,
  Reducer<DetailState, DetailAction, DetailEnvironment> { state, action, environment in
    switch action {
    case let .radioButtonAction(.buttonTap(type)):
      print(type)
      switch type {
      case .chart:
        return .none
      case .quote:
        return .none
      case .conclusion:
        return .none
      default:
        return .none
      }
    case .radioButtonAction:
      return .none
    }
  }
])
