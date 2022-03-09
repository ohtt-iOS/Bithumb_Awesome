//
//  OrderBookDepthResponse.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/10.
//

import Foundation

struct OrderBookDepthResponse: Codable, Equatable {
  let bids: [OrderBookDepthModel]
  let asks: [OrderBookDepthModel]
}
