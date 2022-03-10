//
//  QuoteListRowBlock.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/10.
//

import SwiftUI

struct QuoteListRowBlock: View {
  let type: OrderType
  let data: OrderBookDepthModel
  let width: CGFloat
  
  private var blockWidthRatio: CGFloat {
    return self.width * 0.03
  }
  private var isTypeOfAsk: Bool {
    return self.type == .ask
  }
  
  var body: some View {
    ZStack(alignment: self.isTypeOfAsk ? .trailing : .leading) {
      Rectangle()
        .frame(
          width: self.data.rectangleWidth * self.blockWidthRatio,
          height: self.data.rectangleHeight
        )
        .foregroundColor(self.type.rectangleColor)
      
      HStack {
        Spacer()
          .frame(maxWidth: self.isTypeOfAsk ? .infinity : 0)
        
        Text(self.data.quantity)
          .font(Font.heading7)
          .foregroundColor(Color.aGray4)
          .padding(self.isTypeOfAsk ? .trailing : .leading, 5)
        
        Spacer()
          .frame(maxWidth: self.isTypeOfAsk ? 0 : .infinity)
      }
    }
    .padding(.vertical, 15)
    .background(self.type.backgroundColor)
    .frame(width: self.width)
  }
}
