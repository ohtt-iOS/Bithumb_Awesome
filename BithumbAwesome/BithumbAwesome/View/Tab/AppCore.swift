//
//  AppCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import ComposableArchitecture

struct AppState: Equatable {
  var homeState: HomeState = .init(tickerData: [], socketState: SocketState())
  var assetState: AssetState = .init(assetData: [])
}

enum AppAction {
  case onAppear
  
  case homeAction(HomeAction)
  case assetAction(AssetAction)
}

struct AppEnvironment {
  var mainQueue: AnySchedulerOf<DispatchQueue>
  var homeService: HomeService
}

let appReducer = Reducer.combine([
  homeReducer.pullback(
    state: \.homeState,
    action: /AppAction.homeAction,
    environment: { _ in
      HomeEnvironment(homeService: .home,
                      socketService: .live,
                      mainQueue: .main)
    }
  ) as Reducer<AppState, AppAction, AppEnvironment>,
  assetReducer.pullback(
    state: \.assetState,
    action: /AppAction.assetAction,
    environment: { _ in
      AssetEnvironment(assetClient: AssetService.asset, mainQueue: .main)
    }
  ) as Reducer<AppState, AppAction, AppEnvironment>,
  Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .onAppear:
      return .merge(
        Effect(value: .homeAction(.radioButtonAction(.buttonTap(.koreanWon)))),
        Effect(value: .homeAction(.webSocket(.socketOnOff)))
        )
    case .homeAction:
      return .none
    case .assetAction:
      return .none
    }
  }
])
