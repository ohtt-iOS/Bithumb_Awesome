//
//  FavoriteButton.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import SwiftUI
import ComposableArchitecture

struct FavoriteButton: View {
  let store: Store<FavoriteState, FavoriteAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      (viewStore.isFavorited ? Image.favoriteFillButton : Image.favoriteEmptyButton)
        .resizable()
        .frame(width: 40, height: 40)
        .onTapGesture {
          viewStore.send(.favoriteButtonTap)
        }
    }
  }
}
