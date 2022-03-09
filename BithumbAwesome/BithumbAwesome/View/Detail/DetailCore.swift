//
//  DetailCore.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import ComposableArchitecture

struct DetailState: Equatable {
  var ticker: Ticker
  var selectedButton: AwesomeButtonType = .chart
  var radioButtonState = RadioButtonState(buttons: [.chart,
                                                    .quote,
                                                    .conclusion],
                                          selectedButton: .chart)
  
  var tickerSocketState: SocketState
  var priceState: PriceState
  var chartState: ChartState
  var quoteState: QuoteState = .init()
  var conclusionState: ConclusionState
}

enum DetailAction: Equatable {
  case onAppear
  
  case radioButtonAction(RadioButtonAction)
  case webSocket(SocketAction)
  case priceAction(PriceAction)
  case chartAction(ChartAction)
  case quoteAction(QuoteAction)
  case conclusionAction(ConclusionAction)
}

struct DetailEnvironment {
  var mainQueue: AnySchedulerOf<DispatchQueue>
  var candleStickService: CandleStickService
  var transactionService: TransactionService
  var socketService: SocketService
}

struct TransactionID: Hashable {}
struct CandleID: Hashable {}

let detailReducer = Reducer.combine([
  socketReducer.pullback(
    state: \.tickerSocketState,
    action: /DetailAction.webSocket,
    environment: {
      SocketEnvironment(mainQueue: $0.mainQueue,
                        websocket: $0.socketService)
    }
  ) as Reducer<DetailState, DetailAction, DetailEnvironment>,
  priceReducer.pullback(
    state: \.priceState,
    action: /DetailAction.priceAction,
    environment: { _ in
      PriceEnvironment()
    }
  ) as Reducer<DetailState, DetailAction, DetailEnvironment>,
  chartReducer.pullback(
    state: \.chartState,
    action: /DetailAction.chartAction,
    environment: {
      ChartEnvironment(candleClient: $0.candleStickService,
                       mainQueue: $0.mainQueue)
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
    case .chartAction:
      return .none
      
    case .onAppear:
      return .merge(
        Effect(value: .webSocket(.socketOnOff)),
        Effect(value: .chartAction(.radioButtonAction(.buttonTap(.min_1)))),
        Effect(value: .conclusionAction(.onAppear))
      )
      
    case .webSocket(.webSocket(.didOpenWithProtocol)):
      return .merge(
        Effect(value: .webSocket(.sendFilter("ticker", [state.ticker.underScoreString], ["30M"]))),
        Effect(value: .webSocket(.sendFilter("transaction", [state.ticker.underScoreString], nil)))
      )
    case let .webSocket(.getTicker(ticker)):
      state.ticker = ticker
      return .merge(
        Effect(value: .priceAction(.getTickerData(ticker))),
        Effect(value: .chartAction(.getTickerData(ticker))),
        Effect(value: .conclusionAction(.getTickerData(ticker)))
      )
    case let .webSocket(.getTransaction(transaction)):
      return Effect(value: .conclusionAction(.getTransactionData(transaction)))
    case .webSocket:
      return .none
      
    case .priceAction:
      return .none
    }
  }
])
