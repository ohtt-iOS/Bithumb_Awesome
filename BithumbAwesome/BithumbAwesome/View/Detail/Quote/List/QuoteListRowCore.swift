//
//  QuoteListRowCore.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/10.
//

import ComposableArchitecture

struct QuoteListRowState: Equatable {
  var datas: [OrderBookDepthModel]
}

enum QuoteListRowAction {
}

let quoteListRowReducer = Reducer<
  QuoteListRowState, QuoteListRowAction, Void
> { state, action, _ in
  switch action {
  }
}
