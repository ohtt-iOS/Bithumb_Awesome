//
//  TickerRowView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/03.
//

import SwiftUI
import ComposableArchitecture

struct TickerRowView: View {
  var store: Store<TickerState, TickerAction>

  var body: some View {
    WithViewStore(self.store) { viewStore in
      GeometryReader { g in
        HStack(alignment: .top, spacing: 5) {
          VStack(alignment: .leading) {
            Text("비트코인")
              .lineLimit(2)
              .frame(width: g.size.width/5, alignment: .leading)
              .font(.heading6)
              .minimumScaleFactor(0.8)
              .foregroundColor(Color.aGray3)
            Text("BTC/KRW")
              .font(.heading7)
              .foregroundColor(Color.aGray2)
          }
          
          Spacer()
          Text("46,222,555")
            .font(.heading6)
            .frame(width: g.size.width/4.5, alignment: .trailing)
            .foregroundColor(Color.aBlue1)
          
          
          Spacer()
          VStack(alignment: .trailing) {
            Text("-0.5%" )
              .frame(width: g.size.width/4.5, alignment: .trailing)
              .font(.heading6)
              .foregroundColor(Color.aBlue1)
            Text("-532,000")
              .font(.heading7)
              .foregroundColor(Color.aBlue1)
          }
          
          Spacer()
          
          Text("50,057백만")
            .lineLimit(1)
            .frame(width: g.size.width/6, alignment: .trailing)
            .font(.heading6)
            .minimumScaleFactor(0.5)
            .foregroundColor(Color.aGray3)
          
        }
      }
    }
  }
}
