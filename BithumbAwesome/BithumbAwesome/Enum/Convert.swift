//
//  Convert.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/13.
//

import Foundation

enum Convert {
  static let numberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter
  }()
  
  static func toKRWTradeValue(of tradeValue: String?) -> String {
    guard let btcValue = tradeValue,
          let doubleValue = Double(btcValue)
    else {
      return ""
    }
    let btc: Double = 50000000
    let unit: Double = 1000000
    guard let number = self.numberFormatter.string(
      from: NSNumber(value: Int(btc * doubleValue / unit))
    )
    else {
      return ""
    }
    return number + "백만"
  }
  static func percentText(of percent: String?) -> String {
    guard let percent = percent
    else {
      return "-"
    }
    return percent + "%"
  }
  static func toTransactionAmount(of tradeValue: String?) -> String {
    guard let tradeValue = tradeValue,
          let doubleValue = Double(tradeValue)
    else {
      return ""
    }
    let unit: Double = 1000000
    if doubleValue > unit {
      guard let number = self.numberFormatter.string(
        from: NSNumber(value: Int(doubleValue / unit))
      )
    else {
      return ""
    }
      return number + "백만"
    } else {
      return String(round(doubleValue * 1000) / 1000)
    }
  }
  static func toKRWPrice(btcPrice: String?) -> String {
    guard let btcPrice = btcPrice,
          let doubleValue = Double(btcPrice)
    else {
      return ""
    }
    let btc: Double = 50000000
    guard let number = self.numberFormatter.string(
      from: NSNumber(value: round(btc * doubleValue * 1000) / 1000)
    )
    else {
      return ""
    }
    return number + "백만"
  }
  static func toPrice(price: String?) -> String {
    guard let price = price,
          let doubleValue = Double(price)
    else {
      return ""
    }
    if doubleValue > 1 {
      guard let number = self.numberFormatter.string(from: NSNumber(value: doubleValue))
      else {
        return ""
      }
      return number
    } else {
      return price
    }
  }
  static func toPercentText(percentChange: String?) -> String {
    guard let percent = percentChange,
          let doubleValue = Double(percent)
    else {
      return ""
    }
    if doubleValue > 0 {
      return "▲ \(percent)%"
    } else if doubleValue < 0{
      return "▼ \(doubleValue.magnitude)%"
    } else {
      return "\(percent)%"
    }
  }
}
