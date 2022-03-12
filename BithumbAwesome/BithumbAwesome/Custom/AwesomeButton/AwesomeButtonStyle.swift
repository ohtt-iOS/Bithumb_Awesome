//
//  AwesomeButtonStyle.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/28.
//

import SwiftUI

struct AwesomeButtonStyle: ButtonStyle {
  var isSelected = false
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .font(Font.heading4)
      .frame(height: 40)
      .foregroundColor(isSelected ? Color.aGray1 : Color.aGray3)
      .background(isSelected ? Color.aGray3 : Color.aGray1)
      .cornerRadius(20.0)
  }
}
