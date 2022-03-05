//
//  AssetService.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/03.
//

import Combine
import ComposableArchitecture
import Alamofire

struct AssetService {
  var fetchAssetData: () -> Effect<[Asset], Failure>
  struct Failure: Error, Equatable {}
}

extension AssetService {
  static let asset = AssetService(
    fetchAssetData: {
      Effect.run { subscriber in
        let URL = "https://api.bithumb.com/public/assetsstatus/ALL"
        let headers: HTTPHeaders = [
          "Content-Type": "application/json"
        ]
        let dataRequest = AF.request(
          URL,
          method: .get,
          encoding: JSONEncoding.default,
          headers: headers
        )
        
        // TODO: 디코딩 로직개선
        dataRequest
          .validate(statusCode: 200..<300)
          .responseData { response in
            switch response.result {
            case .success(let value):
              do {
                if let json = try JSONSerialization.jsonObject(with: value, options: []) as? [String: Any] {
                  var items = json["data"] as? [String: Any]
                  let result = try items?.map { key, value -> Asset in
                    let valueData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let assetResponse = try JSONDecoder().decode(AssetData.self, from: valueData)
                    return Asset(ticker: key, data: assetResponse)
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
    }
  )
}
