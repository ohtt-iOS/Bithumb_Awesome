//
//  AssetView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import ComposableArchitecture
import SwiftUI

struct AssetView: View {
  let store: Store<AssetState, AssetAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      Text("Asset")
    }
  }
}

struct AssetView_Previews: PreviewProvider {
  static var previews: some View {
    AssetView(store: Store(
      initialState: AssetState(),
      reducer: assetReducer,
      environment: AssetEnvironment()
    ))
  }
}
