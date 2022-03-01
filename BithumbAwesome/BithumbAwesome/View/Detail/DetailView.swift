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
    VStack(alignment: .leading) {
      ANavigationBarView(titleTextString: "비트코인", presentationMode: self.presentationMode)
      
      PriceView()
        .padding(.leading, 19)
      
      RadioButtonView(
        store: store.scope(
          state: \.radioButtonState,
          action: DetailAction.radioButtonAction
        )
      )
        .padding(.horizontal, 14)
      
      Spacer()
    }
  }
}
