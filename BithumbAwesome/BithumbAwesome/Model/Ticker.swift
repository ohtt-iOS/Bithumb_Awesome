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
  let data: TickerResponse
  let isKRW: Bool
  
  var name: String {
    guard let name = CryptoCurrencyType.init(rawValue: ticker)?.koreanString else { return ticker }
    return name
  }
  
  var textColor: Color {
    guard let value = data.fluctateRate24H,
          let doubleValue = Double(value) else { return Color.aGray2 }
    switch doubleValue {
    case 0:
      return Color.aGray2
    case ..<0:
      return Color.aBlue1
    default:
      return Color.aRed1
    }
  }
}
