//
//  LogoImageView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/12.
//

import SwiftUI

struct LogoImageView: View {
  var body: some View {
    HStack {
      Image.logo
        .resizable()
        .frame(width: 216, height: 61, alignment: .leading)
      
      Spacer()
    }
  }
}
