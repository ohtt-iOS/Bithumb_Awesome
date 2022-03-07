//
//  ChartView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/02.
//

import ComposableArchitecture
import SwiftUI

struct ChartView: View {
  let store: Store<ChartState, ChartAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack {
        Spacer()
          .frame(height: 15)
        
        ChartRadioButtonView(
          store: store.scope(
            state: \.radioButtonState,
            action: ChartAction.radioButtonAction
          )
        )
          .background(Color.aGray1)
        
        CandleChartView(
          chartData: viewStore.candleData,
          chartType: viewStore.radioButtonState.selectedButton
        )
          .frame(maxHeight: .infinity)
      }
    }
  }
}
