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
          Text("02:32:25")
            .lineLimit(2)
            .frame(width: g.size.width/6, height: g.size.height, alignment: .leading)
            .font(.heading6)
            .minimumScaleFactor(0.8)
            .foregroundColor(Color.aGray3)
          
          Spacer()
          Text("3,382,000")
            .font(.heading6)
            .frame(width: g.size.width/3.5, height: g.size.height, alignment: .trailing)
            .foregroundColor(Color.aRed1)
          
          
          Spacer()
          Text("2.5821")
            .frame(width: g.size.width/3.5, height: g.size.height, alignment: .trailing)
            .font(.heading6)
            .foregroundColor(Color.aRed1)
        }
        
      }
    }
  }
}
