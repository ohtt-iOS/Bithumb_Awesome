//
//  QuoteListRow.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/05.
//

import SwiftUI
import ComposableArchitecture

struct QuoteListRow: View {
  var store: Store<QuoteListRowState, QuoteListRowAction>
  
  let type: OrderType
  let blockWidth: CGFloat
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(spacing: QuoteView.rowBlockPadding) {
        ForEach(viewStore.datas, id: \.id) { data in
          HStack(spacing: QuoteView.rowBlockPadding) {
            if self.type == .ask {
              QuoteListRowBlock(type: .ask, data: data, width: self.blockWidth)
            }
            
            HStack {
              Spacer()
              
              Text(data.price)
                .font(Font.heading6)
                .foregroundColor(Color.aRed1)
              
              Spacer()
              
              Text("+0.36%")
                .font(Font.heading7)
                .foregroundColor(Color.aRed1)
                .padding(.trailing, 2.5)
                .padding(.vertical, 15)
            }
            .background(self.type.backgroundColor)
            .frame(width: self.blockWidth)
            
            if self.type == .bid {
              QuoteListRowBlock(type: .bid, data: data, width: self.blockWidth)
            }
          }
        }
      }
    }
  }
}
