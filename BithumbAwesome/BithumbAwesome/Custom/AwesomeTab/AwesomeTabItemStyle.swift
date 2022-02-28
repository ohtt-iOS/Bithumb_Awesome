//
//  AwesomeTabItemStyle.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/27.
//

import SwiftUI
import TabBar

struct AwesomeTabItemStyle: TabItemStyle {
  public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
    ZStack {
      if isSelected {
        Circle()
          .foregroundColor(Color.awsomeColor)
          .frame(width: 40.0, height: 40.0)
      }
      
      Image(systemName: icon)
        .foregroundColor(isSelected ? Color.aGray1 : Color.aGray2)
        .frame(width: 32.0, height: 32.0)
    }
    .padding(.vertical, 8.0)
  }
}
