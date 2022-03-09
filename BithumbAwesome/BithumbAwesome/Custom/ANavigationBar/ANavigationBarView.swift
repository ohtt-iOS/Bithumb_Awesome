//
//  ANavigationBarView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import ComposableArchitecture
import SwiftUI

struct ANavigationBarView: View {
  let tickerData: Ticker
  let presentationMode: Binding<PresentationMode>
  
  private var isFavorited: Bool {
    if let favoriteList = UserDefaults.standard.array(
      forKey: UserDefaultsKey.favoriteList
    ) as? [String],
       favoriteList.contains(self.tickerData.underScoreString) {
      return true
    } else {
      return false
    }
  }
  
  var body: some View {
    HStack(spacing: 8) {
      Image.backButton
        .resizable()
        .frame(width: 50, height: 50)
        .onTapGesture {
          self.presentationMode.wrappedValue.dismiss()
        }
      
      Text(self.tickerData.name)
        .font(Font.heading3)
        .foregroundColor(Color.aGray3)
      
      Spacer()
      
      FavoriteButton(store: Store(
        initialState: FavoriteState(
          tickerData: self.tickerData,
          isFavorited: self.isFavorited
        ),
        reducer: favoriteReducer,
        environment: ()
      ))
        .padding(.trailing, 16)
    }
    .frame(height: 42)
  }
}
