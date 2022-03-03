//
//  AssetListRow.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/02.
//

import SwiftUI

struct AssetListRow: View {
  let asset: Asset
  
  var body: some View {
    HStack {
      AdditionalAssetName(textString: asset.name)
      
      Spacer()
      
      CurrentAssetStatus(
        textString: asset.data.depositStatus == 1 ? "정상" : "중단",
        circleColor: asset.data.depositStatus == 1 ? Color.aBlue1 : Color.aRed1
      )
      
      Spacer()
      
      CurrentAssetStatus(
        textString: asset.data.withdrawalStatus == 1 ? "정상" : "중단",
        circleColor: asset.data.withdrawalStatus == 1 ? Color.aBlue1 : Color.aRed1
      )
    }
    .padding(.horizontal, 20)
  }
}
