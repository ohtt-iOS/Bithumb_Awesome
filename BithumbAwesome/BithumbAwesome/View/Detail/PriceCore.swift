//
//  PriceCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/04.
//

import SwiftUI
import Combine
import ComposableArchitecture

struct PriceState: Equatable {
  var tickerData: Ticker
  var isUnderLine: Bool
  var backgroundColor: Color = Color.aGray1
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
    guard let beforePrice = state.tickerData.closingPrice,
          let nowPrice = ticker.closingPrice
    else {
      return .none
    }
    state.backgroundColor = beforePrice > nowPrice ? Color.aBlue1 : beforePrice < nowPrice ? Color.aRed1 : Color.aGray1
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
