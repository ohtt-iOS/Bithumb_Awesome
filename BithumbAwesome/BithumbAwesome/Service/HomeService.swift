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
  var getFavoriteData: ([String]) -> Effect<[Ticker], Failure>
  struct Failure: Error, Equatable {}
  
}
extension HomeService {
  static let home = HomeService(
    getTickerData: { order, payment in
      Effect.run { subscriber in
        let URL = "https://api.bithumb.com/public/ticker/\(order)_\(payment)"
        print("🔗 URL : \(URL)")
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
                if let json = try JSONSerialization.jsonObject(with: value, options: []) as? [String: Any] {
                  var items = json["data"] as? [String: Any]
                  items?.removeValue(forKey: "date")
                  let result = try items?.map { key, value -> Ticker in
                    let valueData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let tickerResponse = try JSONDecoder().decode(TickerResponse.self, from: valueData)
                    return Ticker(ticker: key, isKRW: payment == "KRW", tickerResponse: tickerResponse)
                  }
                  subscriber.send(result!)
                }
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
    },
    getFavoriteData: { underscope in
      Effect.run { subscriber in
        var tickers: [Ticker] = []
        for ticker in underscope {
          DispatchQueue.global().async {
            // TODO: 고차함수 처리
            requestData(underscope: ticker, completion: { ticker in
              tickers.append(ticker)
              if tickers.count == underscope.count {
                DispatchQueue.main.async {
                  subscriber.send(tickers)
                }
              }
            })
          }
        }
        return AnyCancellable {}
      }
    }
  )
}

private func requestData(underscope: String, completion: @escaping (Ticker) -> Void) {
  let URL = "https://api.bithumb.com/public/ticker/\(underscope)"
  print("🔗 URL : \(URL)")
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
          let result = try JSONDecoder().decode(ResponseSimpleResult<TickerResponse>.self,
                                                from: value)
          let data = underscope.split(separator: "_")
          
          guard let orderCurrency = data.first,
                let paymentCurrency = data.last,
                let tickerResponse = result.data
          else {
            return
          }
          let isKRW = (String(paymentCurrency) == "KRW")
          let ticker = Ticker(
            ticker: String(orderCurrency),
            isKRW: isKRW,
            tickerResponse: tickerResponse
          )
          completion(ticker)
        } catch {
        }
      case .failure(_):
        break
      }
    }
}
