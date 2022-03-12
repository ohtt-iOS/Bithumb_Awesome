//
//  QuoteCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/02.
//

import Combine
import ComposableArchitecture

struct QuoteState: Equatable {
  var bids: [OrderBookDepthModel]
  var asks: [OrderBookDepthModel]
  var transactionData: [Transaction]
  var ticker: Ticker
}

enum QuoteAction: Equatable {
  case onAppear
  case quoteResponse(Result<OrderBookDepthResponse, QuoteService.Failure>)
  case getQuote(OrderBookDepthResponse)
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
        .getOrderBookDepth(state.ticker.ticker)
        .receive(on: environment.mainQueue)
        .catchToEffect(QuoteAction.quoteResponse)
        .cancellable(id: QuoteID(), cancelInFlight: true)
      
    case .quoteResponse(.failure):
      state.bids = []
      state.asks = []
      return .none
      
    case let .quoteResponse(.success(response)):
      state.bids = response.bids
      state.asks = response.asks
      return .none
      
    case let .getQuote(orderBookDepthResponse):
      state.bids = sortedQuoteArray(type: .bid, state, orderBookDepthResponse)
      state.asks = sortedQuoteArray(type: .ask, state, orderBookDepthResponse)
      return .none
    }
}

private func sortedQuoteArray(
  type: OrderType,
  _ state: QuoteState,
  _ response: OrderBookDepthResponse
) -> [OrderBookDepthModel] {
  let originalArray: [OrderBookDepthModel] = (type == .bid) ? state.bids : state.asks
  var responseArray: [OrderBookDepthModel] = (type == .bid) ? response.bids : response.asks
  responseArray = responseArray.filter { data in
    Double(data.quantity) ?? 0 != 0
  }
  var tempArray = originalArray
  
  for data in originalArray {
    for newData in responseArray where data.price == newData.price {
      tempArray.remove(at: tempArray.firstIndex(of: data)!)
    }
  }
  tempArray.append(contentsOf: responseArray)
  tempArray = tempArray.sorted { array, nextArray in
    array.price > nextArray.price
  }
  if tempArray.count > originalArray.count {
    let addedCount = tempArray.count - originalArray.count
    for _ in 1...addedCount {
      switch type {
      case .bid:
        tempArray.removeLast()
      case .ask:
        tempArray.removeFirst()
      }
    }
  }
  
  return tempArray
}
