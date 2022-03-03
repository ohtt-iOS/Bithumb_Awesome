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
      AdditionalAssetName(textString: "가산자산명")

      Spacer()
      
      CurrentAssetStatus(textString: "입금", circleColor: .clear)
      
      Spacer()
      
      CurrentAssetStatus(textString: "출금", circleColor: .clear)
    }
    .font(Font.heading6)
    .foregroundColor(Color.aGray2)
    .padding(.vertical, 10)
    .padding(.horizontal, 20)
  }
}
