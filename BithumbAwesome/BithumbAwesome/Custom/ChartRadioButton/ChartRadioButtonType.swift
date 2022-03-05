//
//  ChartRadioButtonType.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/06.
//

import SwiftUI

enum ChartRadioButtonType: CaseIterable {
  case min_1
  case min_10
  case min_30
  case hour_1
  case hour_24
}

extension ChartRadioButtonType: Identifiable {
  var id: UUID {
    return UUID()
  }
}

extension ChartRadioButtonType {
  var parameter: String {
    switch self {
    case .min_1:
      return "1m"
    case .min_10:
      return "10m"
    case .min_30:
      return "30m"
    case .hour_1:
      return "1h"
    case .hour_24:
      return "24h"
    }
  }
  var title: String {
    switch self {
    case .min_1:
      return "1분"
    case .min_10:
      return "10분"
    case .min_30:
      return "30분"
    case .hour_1:
      return "1시간"
    case .hour_24:
      return "1일"
    }
  }
}
