//
//  TickerRowView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/03.
//

import SwiftUI
import ComposableArchitecture

struct TickerRowView: View {
  var store: Store<TickerState, TickerAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      GeometryReader { g in
        HStack(alignment: .top, spacing: 5) {
          VStack(alignment: .leading) {
            Text(viewStore.ticker.name)
              .lineLimit(2)
              .frame(width: g.size.width/5, alignment: .leading)
              .font(.heading6)
              .minimumScaleFactor(0.8)
              .foregroundColor(Color.aGray3)
            Text(viewStore.ticker.ticker + (viewStore.ticker.isKRW ? "/KRW" : "/BTC"))
              .font(.heading7)
              .foregroundColor(Color.aGray2)
          }
          
          Spacer()
          VStack(alignment: .trailing) {
            Text(Convert.toPrice(price:viewStore.ticker.closingPrice))
              .font(.heading6)
              .frame(width: g.size.width/4.5, alignment: .trailing)
              .foregroundColor(viewStore.ticker.textColor)
            if !viewStore.ticker.isKRW {
              Text(Convert.toKRWPrice(btcPrice: viewStore.ticker.closingPrice))
                .lineLimit(1)
                .font(.heading7)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.aGray2)
            }
          }
          
          Spacer()
          VStack(alignment: .trailing) {
            Text(Convert.percentText(of: viewStore.ticker.fluctateRate24H))
              .frame(width: g.size.width/4.5, alignment: .trailing)
              .font(.heading6)
              .foregroundColor(viewStore.ticker.textColor)
            if viewStore.ticker.isKRW {
              Text(viewStore.ticker.fluctate24H ?? "")
                .font(.heading7)
                .foregroundColor(viewStore.ticker.textColor)
            }
          }
          
          Spacer()
          VStack(alignment: .trailing) {
            Text(Convert.toTransactionAmount(of: viewStore.ticker.accTradeValue24H))
              .lineLimit(1)
              .frame(width: g.size.width/6, alignment: .trailing)
              .font(.heading6)
              .minimumScaleFactor(0.5)
              .foregroundColor(Color.aGray3)
            if !viewStore.ticker.isKRW {
              Text(Convert.toKRWTradeValue(of: viewStore.ticker.accTradeValue24H))
                .frame(alignment: .trailing)
                .font(.heading7)
                .foregroundColor(Color.aGray2)
            }
          }
        }
        .frame(height: 60)
        .padding(.horizontal, 14)
        .background(viewStore.isUnderLine ? viewStore.backgroundColor.opacity(0.1) : Color.clear)
      }
    }
  }
}
