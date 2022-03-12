//
//  AssetView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import SwiftUI
import ComposableArchitecture

struct AssetView: View {
  let store: Store<AssetState, AssetAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(spacing: 0) {
        LogoImageView()
        
        List {
          Section(header: AssetListHeader()) {
            ForEach(viewStore.assetData) { asset in
              AssetListRow(asset: asset)
            }
          }
        }
        .listStyle(.plain)
        .padding(.leading, -20)
      }
      .onAppear {
        viewStore.send(.fetchData)
      }
    }
  }
}
