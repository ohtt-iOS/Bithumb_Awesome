//
//  AssetListHeader.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/02.
//

import SwiftUI

struct AssetListHeader: View {
  var body: some View {
    HStack {
      Text("가산자산명")

      Spacer()
      
      Text("입금")
      
      Spacer()
      
      Text("출금")
    }
    .font(Font.heading6)
    .foregroundColor(Color.aGray2)
    .padding(.vertical, 10)
    .padding(.horizontal, 20)
  }
}
