//
//  AssetClient.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/03.
//

import Combine
import ComposableArchitecture
import Alamofire

struct AssetService {
  var fetchAssetData: () -> Effect<[Any], Failure>
  struct Failure: Error, Equatable {}
}

extension AssetService {
  static let asset = AssetService(
    fetchAssetData: {
      Effect.run { subscriber in
        subscriber.send(completion: .failure(Failure()))
        return AnyCancellable {}
      }
    }
  )
}
