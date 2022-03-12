//
//  TransactionService.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/04.
//

import Combine
import ComposableArchitecture
import Alamofire

struct TransactionService {
  var getTransactionData: (String) -> Effect<[Transaction], Failure>
  struct Failure: Error, Equatable {}
}

extension TransactionService {
  static let transaction = TransactionService(
    getTransactionData: { underscopeString in
      Effect.run { subscriber in
        let URL = AwesomeURL.transactionHistory + "/\(underscopeString)"
        let headers: HTTPHeaders = [
          "Content-Type": "application/json",
        ]
        
        let dataRequest = AF.request(
          URL,
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
