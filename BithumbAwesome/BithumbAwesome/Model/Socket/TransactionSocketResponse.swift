//
//  TransactionSocketResponse.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/08.
//

import Foundation

// MARK: - TransactionSocketResponse
struct TransactionListSocketResponse: Codable, Equatable {
  let list: [TransactionSocketResponse]
}

struct TransactionSocketResponse: Codable, Equatable {
    let symbol, buySellGB, contPrice, contQty: String
    let contAmt, contDtm, updn: String

    enum CodingKeys: String, CodingKey {
        case symbol
        case buySellGB = "buySellGb"
        case contPrice, contQty, contAmt, contDtm, updn
    }
}

// MARK: - TransactionSocketResponse
struct QuoteListSocketResponse: Codable, Equatable {
  let list: [QuoteSocketResponse]
}

struct QuoteSocketResponse: Codable, Equatable {
  let symbol: String
  let orderType: String
  let price: String
  let quantity: String
  let total: String
}
