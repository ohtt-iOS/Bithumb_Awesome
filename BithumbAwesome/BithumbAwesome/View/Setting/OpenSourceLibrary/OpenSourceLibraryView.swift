//
//  OpenSourceLibraryView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/13.
//

import SwiftUI

struct OpenSourceLibraryView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var body: some View {
    VStack {
      HStack(spacing: 8) {
        Image.backButton
          .resizable()
          .frame(width: 50, height: 50)
          .onTapGesture {
            self.presentationMode.wrappedValue.dismiss()
          }
        
        Spacer()
      }
      
      ScrollView {
        VStack {
          ForEach(OpenSourceLibraryType.allCases) { libraryType in
            OpenSourceLibraryDetailView(type: libraryType)
              .padding(.top, 30)
              .padding(.horizontal, 30)
          }
        }
      }
    }
  }
}
