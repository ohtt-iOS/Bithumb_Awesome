//
//  CurrentAssetStatus.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/02.
//

import SwiftUI

struct CurrentAssetStatus: View {
  let textString: String
  let circleColor: Color
  
  var body: some View {
    HStack(spacing: 4) {
      Image.circle
        .resizable()
        .frame(width: 5, height: 5)
        .foregroundColor(self.circleColor)
      
      Text(self.textString)
        .font(.heading6)
    }
    .frame(width: 35, alignment: .leading)
  }
}

