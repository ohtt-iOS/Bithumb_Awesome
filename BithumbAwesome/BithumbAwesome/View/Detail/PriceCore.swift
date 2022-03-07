//
//  PriceCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/04.
//

import ComposableArchitecture

struct PriceState: Equatable {
  var tickerData: Ticker
}

enum PriceAction: Equatable {
  case getTickerData(Ticker)
}

struct PriceEnvironment {
}

let priceReducer = Reducer<PriceState, PriceAction, PriceEnvironment> { state, action, environment in
  switch action {
  case let .getTickerData(ticker):
    state.tickerData = ticker
    return .none
  }
}
