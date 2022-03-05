//
//  AppCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import ComposableArchitecture

struct AppState: Equatable {
  var homeState: HomeState = .init(tickerData: [])
  var assetState: AssetState = .init(assetData: [])
  var settingState: SettingState = .init()
}

enum AppAction {
  case onAppear
//  case tickerResponse(Result<[Ticker], HomeService.Failure>)
  
  case homeAction(HomeAction)
  case assetAction(AssetAction)
  case settingAction(SettingAction)
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
  settingReducer.pullback(
    state: \.settingState,
    action: /AppAction.settingAction,
    environment: { _ in
      SettingEnvironment()
    }
  ) as Reducer<AppState, AppAction, AppEnvironment>,
  Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .onAppear:
      return Effect(value: .homeAction(.radioButtonAction(.buttonTap(.koreanWon))))
    case .homeAction:
      return .none
    case .assetAction:
      return .none
    case .settingAction:
      return .none
    }
  }
])
