//
//  QuoteOrderType.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/05.
//

import SwiftUI

enum QuoteOrderType {
  case bid, ask
}

extension QuoteOrderType {
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
}
