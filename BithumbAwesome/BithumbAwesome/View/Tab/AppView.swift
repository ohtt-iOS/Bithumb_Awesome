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
  
  private enum Item: Int, Tabbable {
    case first = 0
    case second
    case third
    
    var icon: String {
      switch self {
      case .first: return "house"
      case .second: return "menucard"
      case .third: return "gearshape"
      }
    }
    
    var title: String {
      switch self {
      case .first: return "First"
      case .second: return "Second"
      case .third: return "Third"
      }
    }
  }
  
  @State private var selection: Item = .first
  
  var body: some View {
    WithViewStore(store) { viewStore in
      TabBar(selection: $selection) {
        HomeView(
          store: store.scope(
            state: \.homeState,
            action: AppAction.homeAction
          )
        )
          .tabItem(for: Item.first)
        
        AssetView(
          store: store.scope(
            state: \.assetState,
            action: AppAction.assetAction
          )
        )
          .tabItem(for: Item.second)
        
        SettingView(
          store: store.scope(
            state: \.settingState,
            action: AppAction.settingAction
          )
        )
          .tabItem(for: Item.third)
      }
      .tabBar(style: AwesomeTabBarStyle())
      .tabItem(style: AwesomeTabItemStyle())
    }
  }
}
