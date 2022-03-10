//
//  QuoteAdditionalInfomationList.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/05.
//

import SwiftUI

struct QuoteAdditionalInfomationList: View {
  var ticker: Ticker
  
  private let rowHorizontalPadding: CGFloat = 1
  private let rowSpacing: CGFloat = 10
  
  var body: some View {
    VStack(spacing: self.rowSpacing) {
      Spacer()
      
      ListRow(titleString: "거래량", valueString: ticker.unitsTraded24H ?? "")
      ListRow(titleString: "거래금", valueString: ticker.accTradeValue24H ?? "")

      HorizonDivider()
      
      ListRow(titleString: "전일종가", valueString: self.ticker.prevClosingPrice ?? "")
      ListRow(titleString: "시가(당일)", valueString: self.ticker.openingPrice ?? "")
      ListRow(titleString: "고가(당일)", valueString: self.ticker.maxPrice ?? "")
      ListRow(titleString: "저가(당일)", valueString: self.ticker.minPrice ?? "")
    }
    .padding(.horizontal, self.rowHorizontalPadding)
  }
}

private struct ListRow: View {
  let titleString: String
  let valueString: String
  
  private let rowSpacing: CGFloat = 5
  
  var body: some View {
    VStack(spacing: self.rowSpacing) {
      HStack {
        Text(self.titleString)
          .font(Font.heading7)
          .foregroundColor(Color.aGray2)
        
        Spacer()
        
        Text(self.valueString)
          .font(Font.heading7)
          .foregroundColor(Color.aRed1)
      }
      
//      HStack {
//        Spacer()
//        
//        if self.type == .highPrice {
//          Text("0.18%")
//            .font(Font.heading7)
//            .foregroundColor(Color.aRed1)
//        } else if self.type == .lowPrice {
//          Text("-4.8%")
//            .font(Font.heading7)
//            .foregroundColor(Color.aBlue1)
//        }
//      }
    }
  }
}

private enum ListRowType {
  case transactionVolume, transactionAmount
  case closingPrice, marketPrice, highPrice, lowPrice
}

extension ListRowType: CaseIterable, Identifiable {
  var id: UUID {
    return UUID()
  }
}

extension ListRowType {
  var rowTitleString: String {
    switch self {
    case .transactionVolume:
      return "거래량"
    case .transactionAmount:
      return "거래금"
    case .closingPrice:
      return "전일종가"
    case .marketPrice:
      return "시가(당일)"
    case .highPrice:
      return "고가(당일)"
    case .lowPrice:
      return "저가(당일)"
    }
  }
  var rowValueString: String {
    switch self {
    case .transactionVolume:
      return "3.165.686 BTC"
    case .transactionAmount:
      return "1,603,900 억"
    case .closingPrice:
      return "52,989,000"
    case .marketPrice:
      return "52,989,000"
    case .highPrice:
      return "53,087,000"
    case .lowPrice:
      return "50,443,000"
    }
  }
}
