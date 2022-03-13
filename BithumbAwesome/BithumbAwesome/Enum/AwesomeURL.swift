//
//  AwesomeURL.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/12.
//

import Foundation

enum AwesomeURL {
  
  // MARK: bithumb
  static let base: String = "https://api.bithumb.com/public"
  static let assetsStatus: String = AwesomeURL.base + "/assetsstatus/ALL"
  static let ticker: String = AwesomeURL.base + "/ticker"
  static let transactionHistory: String = AwesomeURL.base + "/transaction_history"
  static let candlestick: String = AwesomeURL.base + "/candlestick"
  static let orderbook: String = AwesomeURL.base + "/orderbook"
  
  // MARK: profile
  static let notionPage: String = "https://truth-aerosteon-d09.notion.site/81f08cd8bf224d929ca3fc904806e53e"
  static let kangkyungGithubPage: String = "https://github.com/KangKyung"
  static let ohttGithubPage: String = "https://github.com/ohtt-iOS"
}
