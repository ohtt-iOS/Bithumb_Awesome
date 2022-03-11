//
//  TickerRowCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/03.
//

import ComposableArchitecture
import Combine
import SwiftUI

struct TickerState: Equatable, Identifiable {
  var id: UUID
  var ticker: Ticker
  var isUnderLine: Bool = false
  var backgroundColor: Color = Color.aGray1
}

enum TickerAction: Equatable {
  case getTicker(Ticker)
  case changeToInvisable(Bool)
}

struct TickerEnvironment {
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

struct TickerRowID: Hashable {}

let tickerReducer = Reducer<TickerState, TickerAction, TickerEnvironment> { state, action, environment in
  switch action {
  case let .getTicker(ticker):
    guard let beforePrice = state.ticker.closingPrice,
          let nowPrice = ticker.closingPrice
    else {
      return .none
    }
    state.ticker = ticker
    return .none
    
  case let .changeToInvisable(boolType):
    state.isUnderLine = boolType
    return .none
  }
}
