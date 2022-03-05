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
}

struct PriceEnvironment {
}

let priceReducer = Reducer<PriceState, PriceAction, PriceEnvironment> { state, action, environment in
  switch action {
  }
}
