//
//  AppView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/22.
//

import SwiftUI
import ComposableArchitecture
import TabBar

struct AppView: View {
  let store: Store<AppState, AppAction>
  @State private var selection: AwesomeTabType = .home
  
  init() {
    self.store = Store(initialState: AppState(),
                       reducer: appReducer,
                       environment: AppEnvironment(
                        mainQueue: .main,
                        homeService: HomeService.home)
    )
  }
  
  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationView {
        TabBar(selection: $selection) {
          HomeView(
            store: store.scope(
              state: \.homeState,
              action: AppAction.homeAction
            )
          )
            .tabItem(for: AwesomeTabType.home)
          
          AssetView(
            store: store.scope(
              state: \.assetState,
              action: AppAction.assetAction
            )
          )
            .tabItem(for: AwesomeTabType.asset)
          
          SettingView()
            .tabItem(for: AwesomeTabType.setting)
        }
        .tabBar(style: AwesomeTabBarStyle())
        .tabItem(style: AwesomeTabItemStyle())
      }
      .onAppear {
        viewStore.send(.onAppear)
      }
    }
  }
}
