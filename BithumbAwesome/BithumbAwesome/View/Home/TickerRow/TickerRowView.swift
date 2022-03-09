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
            Text(viewStore.ticker.name)
              .lineLimit(2)
              .frame(width: g.size.width/5, alignment: .leading)
              .font(.heading6)
              .minimumScaleFactor(0.8)
              .foregroundColor(Color.aGray3)
            Text(viewStore.ticker.ticker + (viewStore.ticker.isKRW ? "/KRW" : "/BTC"))
              .font(.heading7)
              .foregroundColor(Color.aGray2)
          }
          
          Spacer()
          VStack(alignment: .trailing) {
            Text(toPrice(price:viewStore.ticker.closingPrice))
              .font(.heading6)
              .frame(width: g.size.width/4.5, alignment: .trailing)
              .foregroundColor(viewStore.ticker.textColor)
            if !viewStore.ticker.isKRW {
              Text(toKRWPrice(btcPrice: viewStore.ticker.closingPrice))
                .lineLimit(1)
                .font(.heading7)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.aGray2)
            }
          }
          
          Spacer()
          VStack(alignment: .trailing) {
            Text((viewStore.ticker.fluctateRate24H ?? "") + "%" )
              .frame(width: g.size.width/4.5, alignment: .trailing)
              .font(.heading6)
              .foregroundColor(viewStore.ticker.textColor)
            if viewStore.ticker.isKRW {
              Text(viewStore.ticker.fluctate24H ?? "")
                .font(.heading7)
                .foregroundColor(viewStore.ticker.textColor)
            }
          }
          
          Spacer()
          VStack(alignment: .trailing) {
            Text(setformat(of: viewStore.ticker.accTradeValue24H))
              .lineLimit(1)
              .frame(width: g.size.width/6, alignment: .trailing)
              .font(.heading6)
              .minimumScaleFactor(0.5)
              .foregroundColor(Color.aGray3)
            if !viewStore.ticker.isKRW {
              Text(toKRWTradeValue(of: viewStore.ticker.accTradeValue24H))
                .frame(alignment: .trailing)
                .font(.heading7)
                .foregroundColor(Color.aGray2)
            }
          }
        }
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

private func toKRWPrice(btcPrice: String?) -> String {
  guard let btcPrice = btcPrice,
        let doubleValue = Double(btcPrice) else { return "" }
  let btc: Double = 50000000
  guard let number = numberFormatter.string(from: NSNumber(value: round(btc * doubleValue * 1000) / 1000)) else { return "" }
  return number + "백만"
}

private func setformat(of tradeValue: String?) -> String {
  guard let tradeValue = tradeValue,
        let doubleValue = Double(tradeValue) else { return "" }
  let unit: Double = 1000000
  if doubleValue > unit {
    guard let number = numberFormatter.string(from: NSNumber(value: Int(doubleValue / unit))) else { return "" }
    return number + "백만"
  } else {
    return String(round(doubleValue * 1000) / 1000)
  }
}

private func toKRWTradeValue(of tradeValue: String?) -> String {
  guard let btcValue = tradeValue,
        let doubleValue = Double(btcValue) else { return "" }
  let btc: Double = 50000000
  let unit: Double = 1000000
  guard let number = numberFormatter.string(from: NSNumber(value: Int(btc * doubleValue / unit))) else { return "" }
  return number + "백만"
}

