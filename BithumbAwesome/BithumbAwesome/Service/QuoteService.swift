//
//  QuoteService.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/04.
//

import Combine
import ComposableArchitecture
import Alamofire

struct QuoteService {
  var getOrderBookDepth: (String) -> Effect<OrderBookDepthResponse, Failure>
  struct Failure: Error, Equatable {}
}

extension QuoteService {
  static let quote = QuoteService(
    getOrderBookDepth: { orderBookType in
      Effect.run { subscriber in
        let URL = AwesomeURL.orderbook + "/\(orderBookType)"
        let headers: HTTPHeaders = [
          "Content-Type": "application/json",
        ]
        let dataRequest = AF.request(
          URL,
          method: .get,
          encoding: JSONEncoding.default,
          headers: headers
        )
        
        dataRequest
          .validate(statusCode: 200..<300)
          .responseData{ (response) in
          switch response.result {
          case .success(let value):
            do {
              let result = try JSONDecoder().decode(
                ResponseSimpleResult<OrderBookDepthResponse>.self,
                from: value
              )
              subscriber.send(result.data!)
            } catch {
              subscriber.send(completion: .failure(Failure()))
            }
          case .failure(_):
            subscriber.send(completion: .failure(Failure()))
            break
          }
        }
        return AnyCancellable {}
      }
    }
  )
}
