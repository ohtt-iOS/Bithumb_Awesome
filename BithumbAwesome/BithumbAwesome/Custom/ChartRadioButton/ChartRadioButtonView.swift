//
//  ChartRadioButtonView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/06.
//

import SwiftUI
import ComposableArchitecture

struct ChartRadioButtonState: Equatable {
  var buttons: [ChartRadioButtonType]
  var selectedButton: ChartRadioButtonType
}

enum ChartRadioButtonAction: Equatable {
  case buttonTap(ChartRadioButtonType)
}


let chartRadioButtonReducer = Reducer<ChartRadioButtonState, ChartRadioButtonAction, Void> { state, action, _ in
  switch action {
  case let .buttonTap(type):
    state.selectedButton = type
    return .none
  }
}

struct ChartRadioButtonView: View {
  var store: Store<ChartRadioButtonState, ChartRadioButtonAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      HStack(spacing: 15) {
        ForEach(viewStore.buttons) { button in
          Button(
            action: { viewStore.send(.buttonTap(button)) },
            label: {
              Text(button.title)
                .font(.heading4)
                .foregroundColor(button == viewStore.selectedButton ? Color.awsomeColor : Color.aGray3)
            }
          )
            .frame(height:40)
            .frame(maxWidth: .infinity)
        }
      }
      .padding(.horizontal, 15)
    }
  }
}


