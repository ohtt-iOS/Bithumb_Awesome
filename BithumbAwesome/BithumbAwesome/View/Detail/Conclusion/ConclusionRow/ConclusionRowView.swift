//
//  ConclusionRowView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/04.
//

import SwiftUI
import ComposableArchitecture

struct ConclusionRowView: View {
  var store: Store<ConclusionRowState, ConclusionRowAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      GeometryReader { g in
        HStack(alignment: .center, spacing: 5) {
          Text(viewStore.data.date)
            .lineLimit(2)
            .frame(width: g.size.width/6, height: g.size.height, alignment: .leading)
            .font(.heading6)
            .minimumScaleFactor(0.8)
            .foregroundColor(Color.aGray3)
          
          Spacer()
          Text(String(viewStore.data.price ?? 0))
            .font(.heading6)
            .frame(width: g.size.width/3.5, height: g.size.height, alignment: .trailing)
            .foregroundColor(Color.aRed1)
          
          Spacer()
          Text(String(viewStore.data.total ?? 0))
            .frame(width: g.size.width/3.5, height: g.size.height, alignment: .trailing)
            .font(.heading6)
            .foregroundColor(Color.aRed1)
        }
      }
    }
  }
}
