//
//  Ticker.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/03.
//

import Foundation

struct Ticker: Codable, Equatable, Identifiable {
  var id = UUID()
  let ticker: String
  let data: TickerResponse
  let isKRW: Bool
}
