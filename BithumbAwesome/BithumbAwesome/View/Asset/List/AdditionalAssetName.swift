//
//  AdditionalAssetName.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/02.
//

import SwiftUI

struct AdditionalAssetName: View {
  let textString: String
  
  var body: some View {
    Text(self.textString)
      .frame(width: 200, alignment: .leading)
      .font(Font.heading6)
      .foregroundColor(Color.aGray3)
  }
}
