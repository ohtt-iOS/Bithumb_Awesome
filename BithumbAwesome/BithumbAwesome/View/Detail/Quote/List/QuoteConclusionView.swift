//
//  QuoteConclusionView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/10.
//

import SwiftUI
import ComposableArchitecture

struct QuoteConclusionView: View {
  var transactionData: [Transaction]
  
  private var isColorRed: Bool {
    return Bool.random()
  }
  
  var body: some View {
    VStack(spacing: 10) {
      ForEach(transactionData, id: \.id) { data in
        HStack {
          Text(toPrice(price: String(data.price ?? 0)))
          
          Spacer()
          
          Text(self.amountOfStickers(priceDouble: data.total))
            .lineLimit(1)
            .minimumScaleFactor(0.8)
        }
        .foregroundColor(self.isColorRed ? Color.aRed1 : Color.aBlue1)
      }
      
      Spacer()
    }
    .font(Font.heading7)
    .padding(.horizontal, 2)
  }
  
  private func textColor(socketPrice: String?, transcationPrice: Double?) -> Color {
    guard let socketPrice = socketPrice,
          let socketDoublePrice = Double(socketPrice),
          let transactionPrice = transcationPrice
    else {
      return Color.aGray3
    }
    
    return socketDoublePrice < transactionPrice ? Color.aRed1 :
    (socketDoublePrice > transactionPrice ? Color.aBlue1 : Color.aGray3)
  }
  private func amountOfStickers(priceDouble price: Double?) -> String {
    let formattedPrice = (price ?? 0) * 0.0000001
    return String(format: "%.4f", formattedPrice)
  }
}

private let numberFormatter: NumberFormatter = {
  let numberFormatter = NumberFormatter()
  numberFormatter.numberStyle = .decimal
  return numberFormatter
}()

private func toPrice(price: String?) -> String {
  guard let price = price,
        let doubleValue = Double(price)
  else {
    return ""
  }
  if doubleValue > 1 {
    guard let number = numberFormatter.string(from: NSNumber(value: doubleValue))
    else {
      return ""
    }
    return number
  } else {
    return price
  }
}
