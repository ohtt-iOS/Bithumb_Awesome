//
//  AwesomeButtonType.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/28.
//

import SwiftUI

enum AwesomeButtonType {
  case koreanWon, bitcoin, interest, popularity
  case chart, quote, conclusion
}

extension AwesomeButtonType: Identifiable {
  var id: UUID {
    return UUID()
  }
}

extension AwesomeButtonType {
  var textString: String {
    switch self {
    case .koreanWon:
      return "원화"
    case .bitcoin:
      return "BTC"
    case .interest:
      return "관심"
    case .popularity:
      return "인기"
    case .chart:
      return "차트"
    case .quote:
      return "호가"
    case .conclusion:
      return "채결"
    }
  }
  var iconImage: Image {
    switch self {
    case .koreanWon:
      return Image.koreanWon
    case .bitcoin:
      return Image.bitcoin
    case .interest:
      return Image.interest
    case .popularity:
      return Image.popularity
    case .chart:
      return Image.chart
    case .quote:
      return Image.quote
    case .conclusion:
      return Image.conclusion
    }
  }
}
