//
//  QuoteSocketService.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/04.
//

import Starscream
import SwiftUI
import Combine

class QuoteSocketManager {
  static let shared = QuoteSocketManager()
  
  private var isConnected: Bool = false
  private let cryptoCurrency: [String] = ["BTC_KRW"]
  private let socket: WebSocket
  
  init() {
    var request = URLRequest(url: URL(string: "wss://pubwss.bithumb.com/pub/ws")!)
    request.timeoutInterval = 5
    self.socket = WebSocket(request: request)
    self.socket.delegate = self
  }
  
  deinit {
    self.disconnect()
    self.socket.delegate = nil
  }
  
  func connect() {
    self.socket.connect()
  }
  
  func disconnect() {
    self.socket.disconnect()
  }
  
  func write() {
    guard self.isConnected
    else {
      return
    }
    
    let parameter: [String: Any] = [
      "type": "orderbookdepth",
      "symbols": self.cryptoCurrency,
      "tickTypes": "30M"
    ]
    self.parseData(with: parameter)
  }
  
  private func parseData(with jsonObject: [String: Any]) {
    do {
      let data = try JSONSerialization.data(withJSONObject: jsonObject)
      if let dataString = String(data: data, encoding: .utf8) {
        self.socket.write(string: dataString)
      }
    } catch {
      print("🚒 데이터 파싱 실패")
    }
  }
}

extension QuoteSocketManager: WebSocketDelegate {
  func didReceive(event: WebSocketEvent, client: WebSocket) {
    switch event {
    case .connected(let headers):
      print("websocket is connected: \(headers)")
    case .disconnected(let reason, let code):
      print("websocket is disconnected: \(reason) with code: \(code)")
    case .text(let text):
      print("received text: \(text)")
    case .binary(let data):
      print("Received data: \(data.count)")
    case .ping(_):
      break
    case .pong(_):
      break
    case .viabilityChanged(_):
      break
    case .reconnectSuggested(_):
      break
    case .cancelled:
      print("websocket is canclled")
    case .error(let error):
      print("websocket is error: \(String(describing: error))")
    }
  }
}
