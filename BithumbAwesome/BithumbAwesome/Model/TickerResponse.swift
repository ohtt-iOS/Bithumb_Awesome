//
//  TickerResponse.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/03.
//

import Foundation

struct TickerResponse: Codable, Equatable {
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
  let date: String?
  
  enum CodingKeys: String, CodingKey {
    case openingPrice = "opening_price"
    case closingPrice = "closing_price"
    case minPrice = "min_price"
    case maxPrice = "max_price"
    case unitsTraded = "units_traded"
    case accTradeValue = "acc_trade_value"
    case prevClosingPrice = "prev_closing_price"
    case unitsTraded24H = "units_traded_24H"
    case accTradeValue24H = "acc_trade_value_24H"
    case fluctate24H = "fluctate_24H"
    case fluctateRate24H = "fluctate_rate_24H"
    case date = "date"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.openingPrice = try? container.decode(String.self, forKey: .openingPrice)
    self.closingPrice = try? container.decode(String.self, forKey: .closingPrice)
    self.minPrice = try? container.decode(String.self, forKey: .minPrice)
    self.maxPrice = try? container.decode(String.self, forKey: .maxPrice)
    self.unitsTraded = try? container.decode(String.self, forKey: .unitsTraded)
    self.accTradeValue = try? container.decode(String.self, forKey: .accTradeValue)
    self.prevClosingPrice = try? container.decode(String.self, forKey: .prevClosingPrice)
    self.unitsTraded24H = try? container.decode(String.self, forKey: .unitsTraded24H)
    self.accTradeValue24H = try? container.decode(String.self, forKey: .accTradeValue24H)
    self.fluctate24H = try? container.decode(String.self, forKey: .fluctate24H)
    self.fluctateRate24H = try? container.decode(String.self, forKey: .fluctateRate24H)
    self.date = try? container.decode(String.self, forKey: .date)
  }
}

