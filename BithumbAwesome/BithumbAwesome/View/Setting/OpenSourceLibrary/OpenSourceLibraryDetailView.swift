//
//  OpenSourceLibraryDetailView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/13.
//

import SwiftUI

struct OpenSourceLibraryDetailView: View {
  let titleString: String
  let contentString: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        Text(self.titleString)
          .font(Font.heading4)
          .foregroundColor(Color.aGray3)
        
        Spacer()
        
        Image.expandButton
          .resizable()
          .frame(width: 24, height: 24)
      }
      
      Text(self.contentString)
        .font(Font.heading6)
        .foregroundColor(Color.aGray3)
        .lineLimit(nil)
    }
    .padding(20)
    .background(Color.aGray1)
    .cornerRadius(10)\
  }
}
