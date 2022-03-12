//
//  ProfileView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/13.
//

import SwiftUI

struct ProfileView: View {
  let textString: String
  
  var body: some View {
    HStack {
      Spacer()
      
      VStack {
        Text(self.textString)
          .font(Font.heading4)
          .foregroundColor(Color.aGray3)
      }
      
      Spacer()
    }
    .padding(.vertical, 20)
    .background(Color.aGray1)
    .cornerRadius(10)
  }
}
