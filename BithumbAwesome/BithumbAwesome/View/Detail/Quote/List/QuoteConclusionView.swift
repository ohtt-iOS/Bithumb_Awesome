//
//  QuoteConclusionView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/10.
//

import ComposableArchitecture
import SwiftUI

struct QuoteConclusionView: View {
  private var isColorRed: Bool {
    return Bool.random()
  }
  
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        HStack {
          Text("체결강도")
            .foregroundColor(Color.aGray2)
          
          Spacer()
          
          Text("165.53%")
            .foregroundColor(self.isColorRed ? Color.aRed1 : Color.aBlue1)
        }
      }
      .padding(.top, 10)
      
      ForEach(0..<50) { _ in
        HStack {
          Text("3,381,000")
          
          Spacer()
          
          Text("0.0660")
        }
        .foregroundColor(self.isColorRed ? Color.aRed1 : Color.aBlue1)
      }
      
      Spacer()
    }
    .font(Font.heading7)
    .padding(.horizontal, 2)
  }
}
