//
//  OrderBookDepthResponse.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/10.
//

import Foundation

struct OrderBookDepthResponse: Codable, Equatable {
  let bids: [OrderBookDepthModel]
  let asks: [OrderBookDepthModel]
  
  init(quoteSocketResponses: [QuoteSocketResponse]) {
    self.bids = convertList(of: quoteSocketResponses, orderType: .bid)
    self.asks = convertList(of: quoteSocketResponses, orderType: .ask)
  }
}

private func convertList(
  of quoteSocketResponses: [QuoteSocketResponse],
  orderType: OrderType
) -> [OrderBookDepthModel] {
  return quoteSocketResponses
    .filter { response in
      response.orderType == orderType.rawValue
    }
    .map { response in
      OrderBookDepthModel(quantity: response.quantity, price: response.price)
    }
}
