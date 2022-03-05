//
//  Candle.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/05.
//

import Foundation

struct Candle: Codable, Equatable, Identifiable {
  var id = UUID()
  let date: Date
  let openPrice: Double?
  let closePrice: Double?
  let highPrice: Double?
  let lowPrice: Double?
  let volume: Double?
  
  init(candleResponse: CandleResponse) {
    self.date = candleResponse.date
    self.openPrice = Double(candleResponse.openPrice)
    self.closePrice = Double(candleResponse.closePrice)
    self.highPrice = Double(candleResponse.highPrice)
    self.lowPrice = Double(candleResponse.lowPrice)
    self.volume = Double(candleResponse.volume)
  }
}
