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
      VStack(spacing: 0) {
        HStack {
          Image.logo
            .resizable()
            .frame(width: 216, height: 61, alignment: .leading)
          Spacer()
        }
        
        List {
          Section(header: AssetListHeader()) {
            ForEach(1..<10) { _ in
              AssetListRow()
            }
          }
        }
        .listStyle(.plain)
        .padding(.leading, -20)
      }
    }
  }
}
