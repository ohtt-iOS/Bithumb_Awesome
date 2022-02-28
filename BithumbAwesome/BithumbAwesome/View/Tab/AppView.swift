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
  
  var body: some View {
    WithViewStore(store) { viewStore in
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
        
        SettingView(
          store: store.scope(
            state: \.settingState,
            action: AppAction.settingAction
          )
        )
          .tabItem(for: AwesomeTabType.setting)
      }
      .tabBar(style: AwesomeTabBarStyle())
      .tabItem(style: AwesomeTabItemStyle())
    }
  }
}
