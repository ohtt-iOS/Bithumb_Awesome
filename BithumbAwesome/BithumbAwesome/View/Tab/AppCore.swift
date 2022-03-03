//
//  AppCore.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import ComposableArchitecture

struct AppState: Equatable {
  var homeState: HomeState = .init(tickerData: [])
  var assetState: AssetState = .init()
  var settingState: SettingState = .init()
}

enum AppAction {
  case onAppear
  case tickerResponse(Result<[Ticker], HomeService.Failure>)
  
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
  Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .onAppear:
      print("appView appear")
      struct TickerId: Hashable {}
      return environment.homeService
        .getTickerData("ALL", "KRW")
        .receive(on: environment.mainQueue)
        .catchToEffect(AppAction.tickerResponse)
        .cancellable(id: TickerId(), cancelInFlight: true)
    case .tickerResponse(.failure):
      state.homeState.tickerData = []
      return .none
    case let .tickerResponse(.success(response)):
      state.homeState.tickerData = response.sorted(by: { $0.ticker < $1.ticker})
      return .none
    case .homeAction:
      return .none
    case .assetAction:
      return .none
    case .settingAction:
      return .none
    }
  }
])
