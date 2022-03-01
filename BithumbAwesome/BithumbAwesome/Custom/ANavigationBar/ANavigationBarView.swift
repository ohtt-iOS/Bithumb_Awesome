//
//  ANavigationBarView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import ComposableArchitecture
import SwiftUI

struct ANavigationBarView: View {
  let titleTextString: String
  let presentationMode: Binding<PresentationMode>
  
  var body: some View {
    HStack(spacing: 8) {
      Image.backButton
        .resizable()
        .frame(width: 50, height: 50)
        .onTapGesture {
          self.presentationMode.wrappedValue.dismiss()
        }
      
      Text(self.titleTextString)
        .font(Font.heading3)
        .foregroundColor(Color.aGray3)
      
      Spacer()
      
      FavoriteButton(store: Store(
        initialState: FavoriteState(),
        reducer: favoriteReducer,
        environment: ()
      ))
        .padding(.trailing, 16)
    }
    .frame(height: 42)
  }
}
