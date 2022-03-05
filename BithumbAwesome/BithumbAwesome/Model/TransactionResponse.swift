//
//  TransactionResponse.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/04.
//


// MARK: - TransactionResponse
struct TransactionResponse: Codable {
  let transactionDate: String
  let type: String
  let unitsTraded: String
  let price: String
  let total: String
  
  enum CodingKeys: String, CodingKey {
    case transactionDate = "transaction_date"
    case type
    case unitsTraded = "units_traded"
    case price, total
  }
}
