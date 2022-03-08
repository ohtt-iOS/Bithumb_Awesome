//
//  Transaction.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/04.
//

import Foundation

struct Transaction: Codable, Equatable, Identifiable {
  enum transactionType: String, Codable {
    case bid = "bid"
    case ask = "ask"
  }
  var id = UUID()
  let transactionDate: String
  let type: transactionType?
  let unitsTraded: Double?
  let price: Double?
  let total: Double?
  
  var date: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    guard let dateTo = dateFormatter.date(from: transactionDate) else {
      return ""
    }
    dateFormatter.dateFormat = "HH:mm:ss"
    return dateFormatter.string(from: dateTo)
  }
  
  init(transactionResponse: TransactionResponse) {
    self.transactionDate = transactionResponse.transactionDate
    self.type = transactionType(rawValue: transactionResponse.type)
    self.unitsTraded = Double(transactionResponse.unitsTraded)
    self.price = Double(transactionResponse.price)
    self.total = Double(transactionResponse.total)
  }
  
  init(transactionSocketResponse: TransactionSocketResponse) {
    let removeCommaDate = transactionSocketResponse.contDtm.split(separator: ".").first
    self.transactionDate = String(removeCommaDate ?? "")
    self.type = transactionType(rawValue: transactionSocketResponse.buySellGB)
    self.unitsTraded = Double(transactionSocketResponse.contQty) // 거래량
    self.price = Double(transactionSocketResponse.contPrice) // 거래가
    self.total = Double(transactionSocketResponse.contAmt) // 거래금액
  }
}
