//
//  AppCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import ComposableArchitecture

struct AppState: Equatable {
  var homeState: HomeState = .init()
  var assetState: AssetState = .init()
  var settingState: SettingState = .init()
}

enum AppAction {
  case homeAction(HomeAction)
  case assetAction(AssetAction)
  case settingAction(SettingAction)
}

struct AppEnvironment { }
let appReducer = Reducer.combine([
  homeReducer.pullback(
    state: \.homeState,
    action: /AppAction.homeAction,
    environment: { _ in
      HomeEnvironment()
    }
  ) as Reducer<AppState, AppAction, AppEnvironment>,
  assetReducer.pullback(
    state: \.assetState,
    action: /AppAction.assetAction,
    environment: { _ in
      AssetEnvironment()
    }
  ) as Reducer<AppState, AppAction, AppEnvironment>,
  settingReducer.pullback(
    state: \.settingState,
    action: /AppAction.settingAction,
    environment: { _ in
      SettingEnvironment()
    }
  ) as Reducer<AppState, AppAction, AppEnvironment>,
  Reducer<AppState, AppAction, AppEnvironment> { state, action, env in
    switch action {
    case .homeAction:
      return .none
    case .assetAction:
      return .none
    case .settingAction:
      return .none
    }
  }
])
