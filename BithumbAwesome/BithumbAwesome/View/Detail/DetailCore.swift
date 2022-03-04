//
//  DetailCore.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import ComposableArchitecture

struct DetailState: Equatable {
  var selectedButton: AwesomeButtonType = .chart
  var radioButtonState = RadioButtonState(buttons: [.chart,
                                                    .quote,
                                                    .conclusion],
                                          selectedButton: .chart)
  var chartState: ChartState = .init()
  var quoteState: QuoteState = .init()
  var conclusionState: ConclusionState = .init(transactionData: [])
}

enum DetailAction: Equatable {
  case onAppear
  case transactionResponse(Result<[Transaction], TransactionService.Failure>)
  
  case radioButtonAction(RadioButtonAction)
  
  case chartAction(ChartAction)
  case quoteAction(QuoteAction)
  case conclusionAction(ConclusionAction)
}

struct DetailEnvironment {
  var mainQueue: AnySchedulerOf<DispatchQueue>
  var transactionService: TransactionService
}

let detailReducer = Reducer.combine([
  chartReducer.pullback(
    state: \.chartState,
    action: /DetailAction.chartAction,
    environment: { _ in
      ChartEnvironment()
    }
  ) as Reducer<DetailState, DetailAction, DetailEnvironment>,
  quoteReducer.pullback(
    state: \.quoteState,
    action: /DetailAction.quoteAction,
    environment: { _ in
      QuoteEnvironment()
    }
  ) as Reducer<DetailState, DetailAction, DetailEnvironment>,
  conclusionReducer.pullback(
    state: \.conclusionState,
    action: /DetailAction.conclusionAction,
    environment: {
      ConclusionEnvironment(transactionService: $0.transactionService,
                            mainQueue: $0.mainQueue)
    }
  ) as Reducer<DetailState, DetailAction, DetailEnvironment>,
  radioButtonReducer.pullback(
    state: \.radioButtonState,
    action: /DetailAction.radioButtonAction,
    environment: { _ in
      RadioButtonEnvironment()
    }
  ) as Reducer<DetailState, DetailAction, DetailEnvironment>,
  Reducer<DetailState, DetailAction, DetailEnvironment> { state, action, environment in
    switch action {
    case let .radioButtonAction(.buttonTap(type)):
      state.selectedButton = type
      switch type {
      case .chart:
        return .none
      case .quote:
        return .none
      case .conclusion:
        return .none
      default:
        return .none
      }
    case .radioButtonAction:
      return .none
    case .conclusionAction:
      return .none
    case .onAppear:
      struct TransactionID: Hashable {}
      return environment.transactionService
        .getTransactionData("BTC", "KRW")
        .receive(on: environment.mainQueue)
        .catchToEffect(DetailAction.transactionResponse)
        .cancellable(id: TransactionID(), cancelInFlight: true)
    case .transactionResponse(.failure):
      state.conclusionState.transactionData = []
      return .none
    case let .transactionResponse(.success(response)):
      state.conclusionState.transactionData = response
      return .none
    }
  }
])
