//
//  QuoteCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/02.
//

import ComposableArchitecture
import Combine

struct QuoteState: Equatable {
  var bids: [OrderBookDepthModel]
  var asks: [OrderBookDepthModel]
}

enum QuoteAction: Equatable {
  case onAppear
  case quoteResponse(Result<OrderBookDepthResponse, QuoteService.Failure>)
}

struct QuoteEnvironment {
  var quoteService: QuoteService
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

struct QuoteID: Hashable {}
let quoteReducer = Reducer<QuoteState, QuoteAction, QuoteEnvironment> { state, action, environment in
    switch action {
    case .onAppear:
      return environment.quoteService
        .getOrderBookDepth("BTC_KRW")
        .receive(on: environment.mainQueue)
        .catchToEffect(QuoteAction.quoteResponse)
        .cancellable(id: QuoteID(), cancelInFlight: true)
      
    case .quoteResponse(.failure):
      state.bids = []
      state.asks = []
      return .none
      
    case let .quoteResponse(.success(response)):
      print("response: \(response)")
      state.bids = response.bids
      state.asks = response.asks
      return .none
    }
}
