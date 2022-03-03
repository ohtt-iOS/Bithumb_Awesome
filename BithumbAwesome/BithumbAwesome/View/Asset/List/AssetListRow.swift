//
//  AssetListRow.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/02.
//

import SwiftUI

struct AssetListRow: View {
  var body: some View {
    HStack {
      AdditionalAssetName(textString: "AdditionalAssetName")
      
      Spacer()
      
      CurrentAssetStatus(textString: "정상", circleColor: Color.aBlue1)
      
      Spacer()
      
      CurrentAssetStatus(textString: "중단", circleColor: Color.aRed1)
    }
    .padding(.horizontal, 20)
  }
}
