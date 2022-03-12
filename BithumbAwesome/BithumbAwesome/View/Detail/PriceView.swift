//
//  PriceView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import SwiftUI
import ComposableArchitecture

struct PriceView: View {
  let store: Store<PriceState, PriceAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(alignment: .leading, spacing: 10) {
        Text(toPrice(price: viewStore.tickerData.closingPrice))
          .font(Font.heading1)
          .foregroundColor(viewStore.tickerData.textColor)
          .background(viewStore.isUnderLine ? viewStore.backgroundColor.opacity(0.1) : Color.clear)
        
        HStack(spacing: 10) {
          Text(toPrice(price: viewStore.tickerData.fluctate24H))
          Text(setPercentText(percentChange:viewStore.tickerData.fluctateRate24H))
        }
        .font(Font.heading2)
        .foregroundColor(viewStore.tickerData.textColor)
      }
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

private func setPercentText(percentChange: String?) -> String {
  guard let percent = percentChange,
        let doubleValue = Double(percent) else { return "" }
  if doubleValue > 0 {
    return "▲ \(percent)%"
  } else if doubleValue < 0{
    return "▼ \(doubleValue.magnitude)%"
  } else {
    return "\(percent)%"
  }
}

