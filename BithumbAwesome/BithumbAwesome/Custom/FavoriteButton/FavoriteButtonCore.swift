//
//  FavoriteButtonCore.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import ComposableArchitecture

struct FavoriteState: Equatable {
  var isFavorited: Bool = false
}

enum FavoriteAction: Equatable {
  case favoriteButtonTap
}

let favoriteReducer = Reducer<FavoriteState, FavoriteAction, Void> { state, action, _ in
  switch action {
  case .favoriteButtonTap:
    state.isFavorited.toggle()
    return .none
  }
}
