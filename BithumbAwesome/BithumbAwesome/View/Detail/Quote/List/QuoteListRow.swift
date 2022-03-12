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
              QuoteListRowBlock(
                type: .ask,
                data: data,
                width: self.blockWidth,
                topQuantity: self.topQuantity(of: viewStore.datas)
              )
            }
            
            HStack {
              Spacer()
              
              Text(toPrice(price: data.price))
                .font(Font.heading6)
                .foregroundColor(
                  self.priceColor(price: data.price, openingPrice: viewStore.openingPrice)
                )
              
              Spacer()
              
              Text(self.pricePercentage(price: data.price, openingPrice: viewStore.openingPrice))
                .font(Font.heading7)
                .foregroundColor(
                  self.priceColor(price: data.price, openingPrice: viewStore.openingPrice)
                )
                .padding(.trailing, 2.5)
                .padding(.vertical, 15)
            }
            .background(self.type.backgroundColor)
            .frame(width: self.blockWidth)
            .border(
              data.price == viewStore.closingPrice ? Color.aGray4 : Color.clear,
              width: 1
            )
            
            if self.type == .bid {
              QuoteListRowBlock(
                type: .bid,
                data: data,
                width: self.blockWidth,
                topQuantity: self.topQuantity(of: viewStore.datas)
              )
            }
          }
        }
      }
    }
  }
  
  private func topQuantity(of array: [OrderBookDepthModel]) -> Double {
    let quantityArray: [Double] = array.map { data in
      return Double(data.quantity) ?? 0
    }

    return quantityArray.max() ?? quantityArray.first!
  }
  private func priceColor(price: String, openingPrice: String?) -> Color {
    let priceInt = Int(price) ?? 0
    let openingPriceInt = Int(openingPrice ?? "0") ?? 0
    return priceInt > openingPriceInt ? Color.aRed1 : Color.aBlue1
  }

  private func pricePercentage(price: String, openingPrice: String?) -> String {
    let priceDouble = Double(price) ?? 0
    let openingPriceDouble = Double(openingPrice ?? "0") ?? 0
    let difference = (priceDouble - openingPriceDouble).magnitude
    let sign = priceDouble > openingPriceDouble ? "+" :
    (priceDouble < openingPriceDouble ? "-" : " ")
    let number = (priceDouble == openingPriceDouble) ? "0.00" :
    String(format: "%.2f", (difference / openingPriceDouble) * 100)
    
    return sign + number + "%"  }
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
