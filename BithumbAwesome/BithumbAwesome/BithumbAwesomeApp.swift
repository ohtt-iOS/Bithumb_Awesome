//
//  BithumbAwesomeApp.swift
//  BithumbAwesome
//
//  Created by soyounglee on 2022/02/22.
//

import ComposableArchitecture
import SwiftUI

@main
struct BithumbAwesomeApp: App {
  var body: some Scene {
    WindowGroup {
      AppView(
        store: Store(
          initialState: AppState(),
          reducer: appReducer,
          environment: AppEnvironment()
        )
      )
    }
  }
}
