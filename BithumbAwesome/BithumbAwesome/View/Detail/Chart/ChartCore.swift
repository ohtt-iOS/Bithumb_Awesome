//
//  ChartCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/02.
//

import ComposableArchitecture

struct ChartState: Equatable {
  var radioButtonState = ChartRadioButtonState(buttons: ChartRadioButtonType.allCases,
                                               selectedButton: .min_1)
  var candleData: [Candle]
}

enum ChartAction: Equatable {
  case candleResponse(Result<[Candle], CandleStickService.Failure>)
  case radioButtonAction(ChartRadioButtonAction)
}

struct ChartEnvironment {
  var candleClient: CandleStickService
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

let chartReducer = Reducer.combine([
  chartRadioButtonReducer.pullback(
    state: \.radioButtonState,
    action: /ChartAction.radioButtonAction,
    environment: ({ _ in
      ()
    })
  ) as Reducer<ChartState, ChartAction, ChartEnvironment>,
  Reducer<ChartState, ChartAction, ChartEnvironment> { state, action, environment in
    switch action {
    case .candleResponse(.failure):
      state.candleData = []
      return .none
      
    case let .candleResponse(.success(response)):
      state.candleData = response
      return .none
      
    case let .radioButtonAction(.buttonTap(type)):
      struct CandleID: Hashable {}
      return environment.candleClient
        .getCandleData("BTC", "KRW", type)
        .receive(on: environment.mainQueue)
        .catchToEffect(ChartAction.candleResponse)
        .cancellable(id: CandleID(), cancelInFlight: true)
    }
  }
])
