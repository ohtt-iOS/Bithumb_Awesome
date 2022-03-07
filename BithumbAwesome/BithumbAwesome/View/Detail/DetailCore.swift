//
//  DetailCore.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import ComposableArchitecture

struct DetailState: Equatable {
  var ticker: Ticker
  var transactionData: [Transaction] = []
  
  var selectedButton: AwesomeButtonType = .chart
  var radioButtonState = RadioButtonState(buttons: [.chart,
                                                    .quote,
                                                    .conclusion],
                                          selectedButton: .chart)
  
  var tickerSocketState: TickerSocketState
  var priceState: PriceState {
    get {
      PriceState(tickerData: ticker)
    }
    set {
      ticker = newValue.tickerData
    }
  }
  var chartState: ChartState = .init(candleData: [])
  var quoteState: QuoteState = .init()
  var conclusionState: ConclusionState {
    get {
      ConclusionState(ticker: ticker,
                      transactionData: self.transactionData)
    }
    set {
      transactionData = newValue.transactionData
    }
  }
}

enum DetailAction: Equatable {
  case onAppear
  
  case radioButtonAction(RadioButtonAction)
  case webSocket(TickerSocketAction)
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

let detailReducer = Reducer.combine([
  tickerSocketReducer.pullback(
    state: \.tickerSocketState,
    action: /DetailAction.webSocket,
    environment: {
      TickerSocketEnvironment(mainQueue: $0.mainQueue,
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
      struct TransactionID: Hashable {}
      struct CandleID: Hashable {}
      return .merge(
        Effect(value: .chartAction(.buttonTap)),
        Effect(value: .conclusionAction(.onAppear)),
        Effect(value: .webSocket(.connectSocket))
      )
    case .webSocket(.webSocket(.didOpenWithProtocol)):
      return Effect(value: .webSocket(.sendFilter("ticker", [state.ticker.underScoreString], ["30M"])))
      
    case let .webSocket(.getTicker(ticker)):
      state.ticker = ticker
      return .none
      
    case .webSocket:
      return .none
    }
  }
])
