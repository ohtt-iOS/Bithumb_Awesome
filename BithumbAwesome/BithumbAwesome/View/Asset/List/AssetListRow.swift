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
      Text("AdditionalAssetName")
      
      Spacer()
      
      Text("정상")
      
      Spacer()
      
      Text("중단")
    }
    .padding(.horizontal, 20)
  }
}
