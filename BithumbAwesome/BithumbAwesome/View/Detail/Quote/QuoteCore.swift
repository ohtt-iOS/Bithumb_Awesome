//
//  QuoteCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/02.
//

import ComposableArchitecture
import Combine

struct QuoteState: Equatable {
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
//      state.transactionData = []
      return .none
      
    case let .quoteResponse(.success(response)):
      print("response: \(response)")
//      state.transactionData = response.sorted(by: { $0.date > $1.date })
      return .none
    }
}
