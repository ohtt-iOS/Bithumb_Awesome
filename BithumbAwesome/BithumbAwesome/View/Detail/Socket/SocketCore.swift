//
//  SocketCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/07.
//

import ComposableArchitecture

struct SocketState: Equatable {
  var ticker: Ticker?
  var connectivityState = ConnectivityState.disconnected
  
  // socket
  enum ConnectivityState: String {
    case connected
    case connecting
    case disconnected
  }
}

enum SocketAction: Equatable {
  // socket
  case getTicker(Ticker)
  case getTransaction(Transaction)
  case socketOnOff
  case pingResponse(NSError?)
  case receivedSocketMessage(Result<SocketService.Message, NSError>)
  case sendFilter(String, [String], [String]?)
  case sendResponse(NSError?)
  case webSocket(SocketService.Action)
}

struct SocketEnvironment {
  var mainQueue: AnySchedulerOf<DispatchQueue>
  var websocket: SocketService
}

let socketReducer = Reducer<SocketState, SocketAction, SocketEnvironment> { state, action, environment in
  //socket
  struct WebSocketId: Hashable {}
  var receiveSocketMessageEffect: Effect<SocketAction, Never> {
    return environment.websocket.receive(WebSocketId())
      .receive(on: environment.mainQueue)
      .catchToEffect()
      .map(SocketAction.receivedSocketMessage)
      .cancellable(id: WebSocketId())
  }
  var sendPingEffect: Effect<SocketAction, Never> {
    return environment.websocket.sendPing(WebSocketId())
      .delay(for: 10, scheduler: environment.mainQueue)
      .map(SocketAction.pingResponse)
      .eraseToEffect()
      .cancellable(id: WebSocketId())
  }
  switch action {
    
  case let .getTicker(ticker):
    state.ticker = ticker
    return .none
    
  case let .getTransaction(transaction):
    return .none
    
  case .socketOnOff:
    switch state.connectivityState {
    case .connected, .connecting:
      state.connectivityState = .disconnected
      return .cancel(id: WebSocketId())
      
    case .disconnected:
      state.connectivityState = .connecting
      return environment.websocket.open(WebSocketId(), URL(string: "wss://pubwss.bithumb.com/pub/ws")!, [])
        .receive(on: environment.mainQueue)
        .map(SocketAction.webSocket)
        .eraseToEffect()
        .cancellable(id: WebSocketId())
    }
    
  case .pingResponse:
    return sendPingEffect
    
  case let .receivedSocketMessage(.success(.string(string))):
    print(string)
    guard let data = string.data(using: .utf8) else {
      print("ERROR - Cannot deserialize data")
      return receiveSocketMessageEffect
    }
    do {

      let decodedData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
      let type = decodedData?["type"] as? String
      switch type {
      case "ticker":
        let response = try JSONDecoder().decode(SocketResponse<TickerSocketResponse>.self, from: data)
        guard let responseData = response.content else {
          return receiveSocketMessageEffect
        }
        return .merge(
          receiveSocketMessageEffect,
          Effect(value: .getTicker(Ticker(socketTickerResponse:responseData)))
        )
      case "transaction":
        let response = try JSONDecoder().decode(SocketResponse<TransactionListSocketResponse>.self, from: data)
        guard let responseData = response.content?.list.first else {
          return receiveSocketMessageEffect
        }
        return .merge(
          receiveSocketMessageEffect,
          Effect(value: .getTransaction(Transaction(transactionSocketResponse: responseData)))
        )
       default:
        return receiveSocketMessageEffect
      }
    }
    catch {
      return receiveSocketMessageEffect
    }
    
  case .receivedSocketMessage(.success):
    return receiveSocketMessageEffect
    
  case .receivedSocketMessage(.failure):
    return .none
    
  case let .sendFilter(type, symbols, tickerTypes):
    var parameter: [String: Any] = [:]
    parameter["type"] = type
    parameter["symbols"] = symbols
    if let tickerTypes = tickerTypes {
      parameter["tickTypes"] = tickerTypes
    }
    print(parameter)
    do {
      let data = try JSONSerialization.data(withJSONObject: parameter)
      guard let dataString = String(data: data, encoding: .utf8) else { return .none }
      return environment.websocket.send(WebSocketId(), .string(dataString))
        .receive(on: environment.mainQueue)
        .eraseToEffect()
        .map(SocketAction.sendResponse)
        .cancellable(id: WebSocketId())
    } catch {
      return .none
    }
    
  case let .sendResponse(error):
    if error != nil {
    }
    return .none
    
  case let .webSocket(.didClose(code, _)):
    state.connectivityState = .disconnected
    return .cancel(id: WebSocketId())
    
  case let .webSocket(.didBecomeInvalidWithError(error)),
    let .webSocket(.didCompleteWithError(error)):
    state.connectivityState = .disconnected
    if error != nil {
    }
    return .cancel(id: WebSocketId())
    
  case .webSocket(.didOpenWithProtocol):
    state.connectivityState = .connected
    return .merge(
      receiveSocketMessageEffect,
      sendPingEffect
    )
  }
}
