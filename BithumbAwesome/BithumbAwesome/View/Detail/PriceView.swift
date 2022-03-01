//
//  PriceView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import SwiftUI

struct PriceView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("46,193,300")
        .font(Font.heading1)
        .foregroundColor(Color.aRed1)
      
      HStack(spacing: 4) {
        Text("-982,000 ")
        Text("(-0.28%)")
      }
      .font(Font.heading2)
      .foregroundColor(Color.aRed1)
    }
  }
}
