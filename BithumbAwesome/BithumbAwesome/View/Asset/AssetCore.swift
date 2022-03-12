//
//  AssetCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import ComposableArchitecture

struct AssetState: Equatable {
  var assetData: [Asset]
}

enum AssetAction: Equatable {
  case assetResponse(Result<[Asset], AssetService.Failure>)
  case fetchData
}

struct AssetEnvironment {
  var assetClient: AssetService
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

struct AssetID: Hashable {}

let assetReducer = Reducer<
  AssetState, AssetAction, AssetEnvironment
> { state, action, environment in
  switch action {
  case .assetResponse(.failure):
    state.assetData = []
    return .none
  case let .assetResponse(.success(response)):
    state.assetData = response
    return .none
  case .fetchData:
    return environment.assetClient
      .fetchAssetData()
      .receive(on: environment.mainQueue)
      .catchToEffect(AssetAction.assetResponse)
      .cancellable(id: AssetID(), cancelInFlight: true)
  }
}
