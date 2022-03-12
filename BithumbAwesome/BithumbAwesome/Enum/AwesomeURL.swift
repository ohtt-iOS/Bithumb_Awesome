//
//  AwesomeURL.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/12.
//

import Foundation

enum AwesomeURL {
  static let base: String = "https://api.bithumb.com/public"
  static let assetsStatus: String = AwesomeURL.base + "/assetsstatus/ALL"
  static let ticker: String = AwesomeURL.base + "/ticker"
  static let transactionHistory: String = AwesomeURL.base + "/transaction_history"
  static let candlestick: String = AwesomeURL.base + "/candlestick"
  static let orderbook: String = AwesomeURL.base + "/orderbook"
}
