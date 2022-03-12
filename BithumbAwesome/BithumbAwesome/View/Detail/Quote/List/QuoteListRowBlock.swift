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
  let topQuantity: Double
  
  private var rectangleWidth: CGFloat {
    let blockWidthRatio = self.data.rectangleWidth / self.topQuantity
    let resultWidth = self.width * blockWidthRatio
    return resultWidth < self.width ? resultWidth : self.width
  }
  private var isTypeOfAsk: Bool {
    return self.type == .ask
  }
  
  var body: some View {
    ZStack(alignment: self.isTypeOfAsk ? .trailing : .leading) {
      Rectangle()
        .frame(width: self.rectangleWidth, height: self.data.rectangleHeight)
        .foregroundColor(self.type.rectangleColor)
      
      HStack {
        Spacer()
          .frame(maxWidth: self.isTypeOfAsk ? .infinity : 0)
        
        Text(String(format: "%.4f", Double(self.data.quantity) ?? 0))
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
