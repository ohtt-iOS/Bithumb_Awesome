//
//  ConclusionCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/02.
//

import ComposableArchitecture

struct ConclusionState: Equatable {
  var ticker: Ticker
  var transactionData: [Transaction]
}

enum ConclusionAction: Equatable {
  case onAppear
  case transactionResponse(Result<[Transaction], TransactionService.Failure>)
}

struct ConclusionEnvironment {
  var transactionService: TransactionService
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

let conclusionReducer = Reducer<ConclusionState, ConclusionAction, ConclusionEnvironment> { state, action, environment in
  switch action {
  case .transactionResponse(.failure):
    state.transactionData = []
    return .none
    
  case let .transactionResponse(.success(response)):
    state.transactionData = response
    return .none
    
  case .onAppear:
    struct ConclusionID: Hashable {}
    return environment.transactionService
      .getTransactionData(state.ticker.underScoreString)
      .receive(on: environment.mainQueue)
      .catchToEffect(ConclusionAction.transactionResponse)
      .cancellable(id: ConclusionID(), cancelInFlight: true)
  
  }
}

