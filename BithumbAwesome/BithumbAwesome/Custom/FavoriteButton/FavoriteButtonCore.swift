//
//  FavoriteButtonCore.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import ComposableArchitecture

struct FavoriteState: Equatable {
  var tickerData: Ticker
  var isFavorited: Bool
}

enum FavoriteAction: Equatable {
  case favoriteButtonTap
}

let favoriteReducer = Reducer<FavoriteState, FavoriteAction, Void> { state, action, _ in
  switch action {
  case .favoriteButtonTap:
    let favoriteList = UserDefaults.standard.array(
      forKey: UserDefaultsKey.favoriteList
    ) as? [String] ?? []
    var newFavoriteList: [String] = favoriteList
    if state.isFavorited {
      newFavoriteList = favoriteList.filter { tickerString in
        tickerString != state.tickerData.underScoreString
      }
    } else {
      newFavoriteList.append(state.tickerData.underScoreString)
    }
    
    state.isFavorited.toggle()
    UserDefaults.standard.set(newFavoriteList, forKey: UserDefaultsKey.favoriteList)
    
    return .none
  }
}
