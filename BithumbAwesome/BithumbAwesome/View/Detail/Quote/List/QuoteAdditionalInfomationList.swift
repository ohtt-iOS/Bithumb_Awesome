//
//  QuoteAdditionalInfomationList.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/05.
//

import SwiftUI

struct QuoteAdditionalInfomationList: View {
  var ticker: Ticker
  
  private let rowHorizontalPadding: CGFloat = 1
  private let rowSpacing: CGFloat = 10
  
  var body: some View {
    VStack(spacing: self.rowSpacing) {
      Spacer()
      
      ListRow(type: .transactionVolume, ticker: self.ticker)
      ListRow(type: .transactionAmount, ticker: self.ticker)

      HorizonDivider()
      
      ListRow(type: .closingPrice, ticker: self.ticker)
      ListRow(type: .marketPrice, ticker: self.ticker)
      ListRow(type: .highPrice, ticker: self.ticker)
      ListRow(type: .lowPrice, ticker: self.ticker)
    }
    .padding(.horizontal, self.rowHorizontalPadding)
  }
}

private struct ListRow: View {
  let type: ListRowType
  let ticker: Ticker
  
  private let rowSpacing: CGFloat = 5
  private var valueColor: Color {
    guard self.type.haveColor
    else {
      return Color.aGray2
    }
    
    let priceInt = Int(self.type.valueString(ticker: self.ticker)) ?? 0
    let closingPriceInt = Int(self.ticker.closingPrice ?? "0") ?? 0
    if priceInt > closingPriceInt {
      return Color.aRed1
    } else if priceInt < closingPriceInt {
      return Color.aBlue1
    } else {
      return Color.aGray2
    }
  }
  
  var body: some View {
    VStack(spacing: self.rowSpacing) {
      HStack {
        Text(self.type.titleString)
          .font(Font.heading7)
          .foregroundColor(Color.aGray2)
        
        Spacer()
        
        Text(self.type.valueString(ticker: self.ticker))
          .font(Font.heading7)
          .foregroundColor(self.valueColor)
      }
      
      HStack {
        Spacer()
        
        if self.type.havePercentage {
          Text(self.type.percentage(ticker: self.ticker))
            .font(Font.heading7)
            .foregroundColor(self.valueColor)
        }
      }
    }
  }
}

private enum ListRowType {
  case transactionVolume, transactionAmount
  case closingPrice, marketPrice, highPrice, lowPrice
}

extension ListRowType {
  var titleString: String {
    switch self {
    case .transactionVolume:
      return "거래량"
    case .transactionAmount:
      return "거래금"
    case .closingPrice:
      return "전일종가"
    case .marketPrice:
      return "시가(당일)"
    case .highPrice:
      return "고가(당일)"
    case .lowPrice:
      return "저가(당일)"
    }
  }
  var havePercentage: Bool {
    switch self {
    case .highPrice, .lowPrice:
      return true
    default:
      return false
    }
  }
  var haveColor: Bool {
    return self.havePercentage
  }
  
  private func price(ticker: Ticker) -> String? {
    switch self {
    case .transactionVolume:
      return ticker.unitsTraded24H
    case .transactionAmount:
      return ticker.accTradeValue24H
    case .closingPrice:
      return ticker.prevClosingPrice
    case .marketPrice:
      return ticker.openingPrice
    case .highPrice:
      return ticker.maxPrice
    case .lowPrice:
      return ticker.minPrice
    }
  }
  func valueString(ticker: Ticker) -> String {
    let price = toPrice(price: self.price(ticker: ticker))
    switch self {
    case .transactionVolume:
      return price + " ETH"
    case .transactionAmount:
      let priceInt = Double(ticker.accTradeValue24H ?? "0") ?? 0
      return String(format: "%.3f", priceInt * 0.00000001) + " 억"
    default:
      return price
    }
  }
  func percentage(ticker: Ticker) -> String {
    let priceDouble = Double(self.price(ticker: ticker) ?? "0") ?? 0
    let closingPriceDouble = Double(ticker.closingPrice ?? "0") ?? 0
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
