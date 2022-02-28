//
//  AwesomeTabType.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/28.
//

import SwiftUI
import TabBar

enum AwesomeTabType: Int, Tabbable {
  case home = 0
  case asset
  case setting
  
  var icon: String {
    switch self {
    case .home: return "house"
    case .asset: return "menucard"
    case .setting: return "gearshape"
    }
  }
  
  var title: String {
    switch self {
    case .home: return "First"
    case .asset: return "Second"
    case .setting: return "Third"
    }
  }
}
