//
//  CandleResponse.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/05.
//

import Foundation

struct CandleResponse: Codable {
  let dateTime: Double
  let openPrice: String
  let closePrice: String
  let highPrice: String
  let lowPrice: String
  let volume: String
  
  var date: Date {
    return Date(timeIntervalSince1970: dateTime / 1000)
  }
}

extension CandleResponse {
  init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    dateTime = try container.decode(Double.self)
    openPrice = try container.decode(String.self)
    closePrice = try container.decode(String.self)
    highPrice = try container.decode(String.self)
    lowPrice = try container.decode(String.self)
    volume = try container.decode(String.self)
  }
}
