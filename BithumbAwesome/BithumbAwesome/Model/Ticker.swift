//
//  Ticker.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/03.
//

import SwiftUI

struct Ticker: Codable, Equatable, Identifiable {
  var id = UUID()
  let ticker: String
  let openingPrice: String?
  let closingPrice: String?
  let minPrice: String?
  let maxPrice: String?
  let unitsTraded: String?
  let accTradeValue: String?
  let prevClosingPrice: String?
  let unitsTraded24H: String?
  let accTradeValue24H: String?
  let fluctate24H: String?
  let fluctateRate24H: String?
  let isKRW: Bool
  
  var name: String {
    guard let name = CryptoCurrencyType.init(rawValue: ticker)?.koreanString
    else {
      return ticker
    }
    return name
  }
  
  var textColor: Color {
    guard let value = fluctateRate24H,
          let doubleValue = Double(value)
    else {
      return Color.aGray2
    }
    switch doubleValue {
    case 0:
      return Color.aGray2
    case ..<0:
      return Color.aBlue1
    default:
      return Color.aRed1
    }
  }
  
  var underScoreString: String {
    let lastString: String = isKRW ? "KRW" : "BTC"
    return "\(ticker)_\(lastString)"
  }
  
  init(ticker: String, isKRW: Bool, tickerResponse: TickerResponse) {
    self.ticker = ticker
    self.isKRW = isKRW
    self.openingPrice = tickerResponse.openingPrice
    self.closingPrice = tickerResponse.closingPrice
    self.minPrice = tickerResponse.minPrice
    self.maxPrice = tickerResponse.maxPrice
    self.unitsTraded = tickerResponse.unitsTraded
    self.accTradeValue = tickerResponse.accTradeValue
    self.prevClosingPrice = tickerResponse.prevClosingPrice
    self.unitsTraded24H = tickerResponse.unitsTraded24H
    self.accTradeValue24H = tickerResponse.accTradeValue24H
    self.fluctate24H = tickerResponse.fluctate24H
    self.fluctateRate24H = tickerResponse.fluctateRate24H
  }
  
  init(socketTickerResponse: TickerSocketResponse) {
    let list = socketTickerResponse.symbol.split(separator: "_")
    self.ticker = String(list.first!)
    self.isKRW = (String(list.last!) == "KRW")
    self.openingPrice = socketTickerResponse.openPrice
    self.closingPrice = socketTickerResponse.closePrice
    self.minPrice = socketTickerResponse.lowPrice
    self.maxPrice = socketTickerResponse.highPrice
    self.unitsTraded = socketTickerResponse.volume
    self.accTradeValue = socketTickerResponse.value
    self.prevClosingPrice = socketTickerResponse.prevClosePrice
    self.unitsTraded24H = socketTickerResponse.volume
    self.accTradeValue24H = socketTickerResponse.value
    self.fluctate24H = socketTickerResponse.chgAmt
    self.fluctateRate24H = socketTickerResponse.chgRate
  }
}
