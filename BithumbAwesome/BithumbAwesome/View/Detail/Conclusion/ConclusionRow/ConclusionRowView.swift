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
        VStack(spacing: 0) {
          HStack(alignment: .center, spacing: 5) {
            Text(viewStore.data.date)
              .lineLimit(2)
              .frame(width: g.size.width/6, height: g.size.height, alignment: .center)
              .font(.heading6)
              .minimumScaleFactor(0.8)
              .foregroundColor(Color.aGray3)
            
            VerticalDivider()
            Spacer()
            
            Text(String(viewStore.data.price ?? 0))
              .font(.heading6)
              .frame(width: g.size.width/3.5, height: g.size.height, alignment: .trailing)
              .foregroundColor(textColor(socketPrice: viewStore.ticker.closingPrice, transcationPrice: viewStore.data.price))
            
            VerticalDivider()
            Spacer()
            
            Text(String(viewStore.data.unitsTraded ?? 0))
              .frame(width: g.size.width/3.5, height: g.size.height, alignment: .trailing)
              .font(.heading6)
              .foregroundColor(textColor(socketPrice: viewStore.ticker.closingPrice, transcationPrice: viewStore.data.price))
          }
          HorizonDivider()
        }
      }
    }
  }
  
  func textColor(socketPrice: String?, transcationPrice: Double?) -> Color {
    guard let socketPrice = socketPrice,
          let socketDoublePrice = Double(socketPrice),
          let transactionPrice = transcationPrice
    else {
      return Color.aGray3
    }
    
    return socketDoublePrice < transactionPrice ? Color.aRed1 : socketDoublePrice == transactionPrice ? Color.aGray3 : Color.aBlue1
  }
}
