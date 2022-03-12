//
//  SettingButtonType.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/13.
//

import SwiftUI

enum SettingButtonType {
  case license, notion
}

extension SettingButtonType {
  var textString: String {
    switch self {
    case .license:
      return "오픈소스 라이선스"
    case .notion:
      return "어썸이 궁금하다면 ?"
    }
  }
}
