//
//  TickerSocketResponse.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/07.
//

import Foundation

// MARK: - TickerSocketResponse
struct TickerSocketResponse: Codable, Equatable {
  let tickType, date, time, openPrice: String
  let closePrice, lowPrice, highPrice, value: String
  let volume, sellVolume, buyVolume, prevClosePrice: String
  let chgRate, chgAmt, volumePower, symbol: String
}

