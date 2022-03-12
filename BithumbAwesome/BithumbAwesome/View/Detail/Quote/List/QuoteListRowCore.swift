//
//  QuoteListRowCore.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/10.
//

import ComposableArchitecture

struct QuoteListRowState: Equatable {
  var datas: [OrderBookDepthModel]
  var closingPrice: String?
  var openingPrice: String?
}

enum QuoteListRowAction {
}

let quoteListRowReducer = Reducer<
  QuoteListRowState, QuoteListRowAction, Void
> { state, action, _ in
  return .none
}
