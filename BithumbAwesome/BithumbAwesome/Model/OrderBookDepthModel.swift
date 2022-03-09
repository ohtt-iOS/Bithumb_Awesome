//
//  OrderBookDepthModel.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/10.
//

import Foundation

struct OrderBookDepthModel: Codable, Equatable, Identifiable {
  let id: UUID = UUID()
  let quantity: String
  let price: String
}
