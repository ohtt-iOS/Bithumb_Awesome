//
//  QuoteListRow.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/05.
//

import SwiftUI

struct QuoteListRow: View {
  let type: QuoteOrderType
  let blockWidth: CGFloat
  
  var body: some View {
    VStack(spacing: QuoteView.rowBlockPadding) {
      ForEach(0..<30) { index in
        HStack(spacing: QuoteView.rowBlockPadding) {
          if self.type == .ask {
            HStack {
              Spacer()
              
              Text("2.0100")
                .font(Font.heading7)
                .foregroundColor(Color.aGray4)
                .padding(.trailing, 5)
                .padding(.vertical, 15)
            }
            .background(self.type.backgroundColor)
            .frame(width: self.blockWidth)
          }
          
          HStack {
            Spacer()
            
            Text("3,385,000")
              .font(Font.heading6)
              .foregroundColor(Color.aRed1)
            
            Spacer()
            
            Text("+0.36%")
              .font(Font.heading7)
              .foregroundColor(Color.aRed1)
              .padding(.trailing, 2.5)
              .padding(.vertical, 15)
          }
          .background(self.type.backgroundColor)
          .frame(width: self.blockWidth)
          
          if self.type == .bid {
            HStack {
              Text("2.0100")
                .font(Font.heading7)
                .foregroundColor(Color.aGray4)
                .padding(.leading, 5)
                .padding(.vertical, 15)
              
              Spacer()
            }
            .background(self.type.backgroundColor)
            .frame(width: self.blockWidth)
          }
        }
      }
    }
  }
}
