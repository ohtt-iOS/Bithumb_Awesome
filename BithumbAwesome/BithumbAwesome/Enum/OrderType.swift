//
//  OrderType.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/10.
//

import SwiftUI

enum OrderType: String, Codable {
  case bid = "bid"
  case ask = "ask"
}

extension OrderType {
  var color: Color {
    switch self {
    case .bid:
      return Color.aRed1
    case .ask:
      return Color.aBlue1
    }
  }
  var backgroundColor: Color {
    return self.color.opacity(0.1)
  }
  var rectangleColor: Color {
    return self.color.opacity(0.2)
  }
}
