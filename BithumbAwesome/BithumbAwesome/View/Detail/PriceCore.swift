//
//  PriceCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/04.
//

import ComposableArchitecture
import Combine

struct PriceState: Equatable {
  var tickerData: Ticker
  var isUnderLine: Bool
}

enum PriceAction: Equatable {
  case getTickerData(Ticker)
  case changeToInvisable(Bool)
}

struct PriceEnvironment {
}

let priceReducer = Reducer<PriceState, PriceAction, PriceEnvironment> { state, action, environment in
  switch action {
  case let .getTickerData(ticker):
    state.tickerData = ticker
    state.isUnderLine = true
    return Effect.run { subscriber in
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        subscriber.send(.changeToInvisable(false))
      }
      return AnyCancellable { }
    }
    
  case let .changeToInvisable(boolType):
    state.isUnderLine = boolType
    return .none
  }
}
