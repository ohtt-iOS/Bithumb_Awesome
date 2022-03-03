//
//  TransactionService.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/04.
//

import Alamofire
import Combine
import ComposableArchitecture

struct TransactionService {
  var getTransactionData: (String, String) -> Effect<[Transaction], Failure>
  struct Failure: Error, Equatable {}
}

extension TransactionService {
  static let candle = TransactionService(
    getTransactionData: { order, payment in
      Effect.run { subscriber in
        let URL = "https://api.bithumb.com/public/transaction_history/\(order)_\(payment)"
        let headers: HTTPHeaders = [
          "Content-Type": "application/json",
        ]
        
        let dataRequest = AF.request(URL,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: headers
        )
        
        dataRequest.responseData{ (response) in
          switch response.result {
          case .success(_):
            guard let value = response.value,
                  let status = response.response?.statusCode else { return }
            switch status {
            case 200:
              do {
                let result = try JSONDecoder().decode(ResponseResult<TransactionResponse>.self, from: value)
                let data = result.data?.map { Transaction(transactionResponse: $0) }
                  subscriber.send(data!)
              } catch {
                subscriber.send(completion: .failure(Failure()))
              }
            default:
              break
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
