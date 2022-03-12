//
//  SettingView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import SwiftUI
import ComposableArchitecture

struct SettingView: View {
  var body: some View {
    VStack(spacing: 20) {
      LogoImageView()
      
      SettingButtonView(textString: "오픈소스 라이선스")
      
      SettingButtonView(textString: "어썸이 궁금하다면 ?")
      
      HStack(spacing: 20) {
        ProfileView(textString: "강경 @KangKyung")
        
        ProfileView(textString: "오뜨 @ohtt-iOS")
      }
      
      Spacer()
    }
    .padding(.horizontal, 20)
  }
}
