//
//  PriceView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import SwiftUI
import ComposableArchitecture

struct PriceView: View {
  let store: Store<PriceState, PriceAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(alignment: .leading, spacing: 10) {
        Text(viewStore.tickerData.closingPrice ?? "")
          .font(Font.heading1)
          .foregroundColor(viewStore.tickerData.textColor)
        
        HStack(spacing: 10) {
          Text(viewStore.tickerData.fluctate24H ?? "")
          Text((viewStore.tickerData.fluctateRate24H ?? "") + "%" )
        }
        .font(Font.heading2)
        .foregroundColor(viewStore.tickerData.textColor)
      }
    }
  }
}
