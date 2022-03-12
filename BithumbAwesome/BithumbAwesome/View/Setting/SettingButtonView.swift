//
//  SettingButtonView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/13.
//

import SwiftUI

struct SettingButtonView: View {
  let textString: String
  
  var body: some View {
    HStack {
      Text(self.textString)
        .font(Font.heading4)
        .foregroundColor(Color.aGray3)
      
      Spacer()
      
      Image.nextButton
        .resizable()
        .frame(width: 24, height: 24)
    }
    .padding(20)
    .background(Color.aGray1)
    .cornerRadius(10)
  }
}
