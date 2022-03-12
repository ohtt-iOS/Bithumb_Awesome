//
//  SettingView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import SwiftUI
import ComposableArchitecture

struct SettingView: View {
  let store: Store<SettingState, SettingAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      Text("Setting")
    }
  }
}

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView(store: Store(
      initialState: SettingState(),
      reducer: settingReducer,
      environment: SettingEnvironment()
    ))
  }
}
