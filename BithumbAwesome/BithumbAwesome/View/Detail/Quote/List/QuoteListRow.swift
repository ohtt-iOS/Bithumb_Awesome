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
              
              Text(toPrice(price: data.price))
                .font(Font.heading6)
                .foregroundColor(
                  self.priceColor(price: data.price, closingPrice: viewStore.closingPrice)
                )
              
              Spacer()
              
              Text(self.pricePercentage(price: data.price, closingPrice: viewStore.closingPrice))
                .font(Font.heading7)
                .foregroundColor(
                  self.priceColor(price: data.price, closingPrice: viewStore.closingPrice)
                )
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
  
  private func priceColor(price: String, closingPrice: String?) -> Color {
    let priceInt = Int(price) ?? 0
    let closingPriceInt = Int(closingPrice ?? "0") ?? 0
    if priceInt > closingPriceInt {
      return Color.aRed1
    } else if priceInt < closingPriceInt {
      return Color.aBlue1
    } else {
      return Color.aGray4
    }
  }
  private func pricePercentage(price: String, closingPrice: String?) -> String {
    let priceDouble = Double(price) ?? 0
    let closingPriceDouble = Double(closingPrice ?? "0") ?? 0
    if priceDouble > closingPriceDouble {
      return "+\(String(format: "%.2f", priceDouble / closingPriceDouble * 0.01))%"
    } else if priceDouble < closingPriceDouble {
      return "-\(String(format: "%.2f", closingPriceDouble / priceDouble * 0.01))%"
    } else {
      return " 0.00%"
    }
  }
}

private let numberFormatter: NumberFormatter = {
  let numberFormatter = NumberFormatter()
  numberFormatter.numberStyle = .decimal
  return numberFormatter
}()

private func toPrice(price: String?) -> String {
  guard let price = price,
        let doubleValue = Double(price) else { return "" }
  if doubleValue > 1 {
    guard let number = numberFormatter.string(from: NSNumber(value: doubleValue)) else { return "" }
    return number
  } else {
    return price
  }
}
