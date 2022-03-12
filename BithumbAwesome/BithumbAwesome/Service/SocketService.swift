//
//  SocketService.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/07.
//

import SwiftUI
import Combine
import ComposableArchitecture

struct SocketService {
  enum Action: Equatable {
    case didBecomeInvalidWithError(NSError?)
    case didClose(code: URLSessionWebSocketTask.CloseCode, reason: Data?)
    case didCompleteWithError(NSError?)
    case didOpenWithProtocol(String?)
  }

  enum Message: Equatable {
    case data(Data)
    case string(String)

    init?(_ message: URLSessionWebSocketTask.Message) {
      switch message {
      case let .data(data):
        self = .data(data)
      case let .string(string):
        self = .string(string)
      @unknown default:
        return nil
      }
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
      switch (lhs, rhs) {
      case let (.data(lhs), .data(rhs)):
        return lhs == rhs
      case let (.string(lhs), .string(rhs)):
        return lhs == rhs
      case (.data, _), (.string, _):
        return false
      }
    }
  }

  var cancel: (AnyHashable, URLSessionWebSocketTask.CloseCode, Data?) -> Effect<Never, Never>
  var open: (AnyHashable, URL, [String]) -> Effect<Action, Never>
  var receive: (AnyHashable) -> Effect<Message, NSError>
  var send: (AnyHashable, URLSessionWebSocketTask.Message) -> Effect<NSError?, Never>
  var sendPing: (AnyHashable) -> Effect<NSError?, Never>
}

extension SocketService {
  static let live = SocketService(
    cancel: { id, closeCode, reason in
      .fireAndForget {
        dependencies[id]?.task.cancel(with: closeCode, reason: reason)
        dependencies[id]?.subscriber.send(completion: .finished)
        dependencies[id] = nil
      }
    },
    open: { id, url, protocols in
      Effect.run { subscriber in
        let delegate = WebSocketDelegate(
          didBecomeInvalidWithError: {
            subscriber.send(.didBecomeInvalidWithError($0 as NSError?))
          },
          didClose: {
            subscriber.send(.didClose(code: $0, reason: $1))
          },
          didCompleteWithError: {
            subscriber.send(.didCompleteWithError($0 as NSError?))
          },
          didOpenWithProtocol: {
            subscriber.send(.didOpenWithProtocol($0))
          })
        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
        let task = session.webSocketTask(with: url, protocols: protocols)
        task.resume()
        dependencies[id] = Dependencies(delegate: delegate, subscriber: subscriber, task: task)
        return AnyCancellable {
          task.cancel(with: .normalClosure, reason: nil)
          dependencies[id]?.subscriber.send(completion: .finished)
          dependencies[id] = nil
        }
      }
    },
    receive: { id in
      .future { callback in
        dependencies[id]?.task.receive { result in
          switch result.map(Message.init) {
          case let .success(.some(message)):
            callback(.success(message))
          case .success(.none):
            callback(.failure(NSError.init(domain: "co.ohtt", code: 1)))
          case let .failure(error):
            callback(.failure(error as NSError))
          }
        }
      }
    },
    send: { id, message in
      .future { callback in
        dependencies[id]?.task.send(message) { error in
          callback(.success(error as NSError?))
        }
      }
    },
    sendPing: { id in
      .future { callback in
        dependencies[id]?.task.sendPing { error in
          callback(.success(error as NSError?))
        }
      }
    })
}

private var dependencies: [AnyHashable: Dependencies] = [:]
private struct Dependencies {
  let delegate: URLSessionWebSocketDelegate
  let subscriber: Effect<SocketService.Action, Never>.Subscriber
  let task: URLSessionWebSocketTask
}

private class WebSocketDelegate: NSObject, URLSessionWebSocketDelegate {
  let didBecomeInvalidWithError: (Error?) -> Void
  let didClose: (URLSessionWebSocketTask.CloseCode, Data?) -> Void
  let didCompleteWithError: (Error?) -> Void
  let didOpenWithProtocol: (String?) -> Void

  init(
    didBecomeInvalidWithError: @escaping (Error?) -> Void,
    didClose: @escaping (URLSessionWebSocketTask.CloseCode, Data?) -> Void,
    didCompleteWithError: @escaping (Error?) -> Void,
    didOpenWithProtocol: @escaping (String?) -> Void
  ) {
    self.didBecomeInvalidWithError = didBecomeInvalidWithError
    self.didOpenWithProtocol = didOpenWithProtocol
    self.didCompleteWithError = didCompleteWithError
    self.didClose = didClose
  }

  func urlSession(
    _ session: URLSession,
    webSocketTask: URLSessionWebSocketTask,
    didOpenWithProtocol protocol: String?
  ) {
    self.didOpenWithProtocol(`protocol`)
  }

  func urlSession(
    _ session: URLSession,
    webSocketTask: URLSessionWebSocketTask,
    didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
    reason: Data?
  ) {
    self.didClose(closeCode, reason)
  }

  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    self.didCompleteWithError(error)
  }

  func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
    self.didBecomeInvalidWithError(error)
  }
}
