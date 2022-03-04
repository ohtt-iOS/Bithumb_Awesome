//
//  ChartCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/02.
//

import ComposableArchitecture

struct ChartState: Equatable {
  var candleData: [Candle]
}

enum ChartAction: Equatable {
  case candleResponse(Result<[Candle], CandleStickService.Failure>)
  case buttonTap
}

struct ChartEnvironment {
  var candleClient: CandleStickService
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

let chartReducer = Reducer<ChartState, ChartAction, ChartEnvironment> { state, action, environment in
  switch action {
  case .candleResponse(.failure):
    state.candleData = []
    return .none
    
  case let .candleResponse(.success(response)):
    state.candleData = response
    return .none
    
  case .buttonTap:
    struct CandleID: Hashable {}
    return environment.candleClient
      .getCandleData()
      .receive(on: environment.mainQueue)
      .catchToEffect(ChartAction.candleResponse)
      .cancellable(id: CandleID(), cancelInFlight: true)
  }
}
