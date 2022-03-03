//
//  HomeService.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/03.
//

import Alamofire
import Combine
import ComposableArchitecture

struct HomeService {
  var getTickerData: (String, String) -> Effect<[Ticker], Failure>
  struct Failure: Error, Equatable {}
  
}
extension HomeService {
  static let home = HomeService(
    getTickerData: { order, payment in
      Effect.run { subscriber in
        let URL = "https://api.bithumb.com/public/ticker/\(order)_\(payment)"
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
                if let json = try JSONSerialization.jsonObject(with: value, options: []) as? [String: Any] {
                  var items = json["data"] as? [String: Any]
                  items?.removeValue(forKey: "date")
                  let result = try items?.map { key, value -> Ticker in
                    let valueData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let tickerResponse = try JSONDecoder().decode(TickerResponse.self, from: valueData)
                    return Ticker(ticker: key, data: tickerResponse, isKRW: payment == "KRW")
                  }
                  subscriber.send(result!)
                }
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
