//
//  ChartService.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/05.
//


import Alamofire
import Combine
import ComposableArchitecture

struct CandleStickService {
  var getCandleData: () -> Effect<[Candle], Failure>
  struct Failure: Error, Equatable {}
  
}
extension CandleStickService {
  static let candle = CandleStickService(
    getCandleData: {
      Effect.run { subscriber in
        let URL = "https://api.bithumb.com/public/candlestick/BTC_KRW/3m"
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
                let result = try JSONDecoder().decode(ResponseResult<CandleResponse>.self, from: value)
                let data = result.data?.map { Candle(candleResponse: $0) }
                subscriber.send(data!)
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

