//
//  DetailView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/01.
//

import SwiftUI
import ComposableArchitecture

struct DetailView: View {
  let store: Store<DetailState, DetailAction>
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(alignment: .leading) {
        ANavigationBarView(titleTextString: viewStore.ticker.name,
                           presentationMode: self.presentationMode)
        
        PriceView(
          store: store.scope(
            state: \.priceState,
            action: DetailAction.priceAction
          )
        )
          .padding(.leading, 19)
        
        RadioButtonView(
          store: store.scope(
            state: \.radioButtonState,
            action: DetailAction.radioButtonAction
          )
        )
          .id(UUID())
          .padding(.horizontal, 14)
        
        view(type: viewStore.selectedButton)
          .frame(maxHeight: .infinity)
      }
      .onAppear {
        viewStore.send(.onAppear)
      }
    }
  }
  
  func view(type: AwesomeButtonType) -> some View {
    VStack {
      switch type {
      case .chart:
        ChartView(
          store: store.scope(
            state: \.chartState,
            action: DetailAction.chartAction
          )
        )
      case .quote:
        QuoteView(
          store: store.scope(
            state: \.quoteState,
            action: DetailAction.quoteAction
          )
        )
      case .conclusion:
        ConclusionView(
          store: store.scope(
            state: \.conclusionState,
            action: DetailAction.conclusionAction
          )
        )
      default:
        Text("error")
      }
    }
  }
}
