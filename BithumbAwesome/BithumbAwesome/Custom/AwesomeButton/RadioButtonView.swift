//
//  RadioButtonView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/28.
//

import SwiftUI
import ComposableArchitecture

struct RadioButtonState: Equatable {
  var buttons: [AwesomeButtonType]
  var selectedButton: AwesomeButtonType
}

enum RadioButtonAction: Equatable {
  case buttonTap(AwesomeButtonType)
}

struct RadioButtonEnvironment {
}

let radioButtonReducer = Reducer<RadioButtonState, RadioButtonAction, RadioButtonEnvironment> { state, action, environment in
  switch action {
  case let .buttonTap(type):
    state.selectedButton = type
    return .none
  }
}

struct RadioButtonView: View {
  var store: Store<RadioButtonState, RadioButtonAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      HStack(spacing: 15) {
        ForEach(viewStore.buttons) { button in
          let selectedState = button == viewStore.selectedButton
          Button(
            action: {
              viewStore.send(.buttonTap(button)) },
            label: {
              HStack(spacing: 5) {
                button.iconImage
                  .foregroundColor(button == viewStore.selectedButton ? Color.aGray1 : Color.aGray3)
                Text(button.textString)
              }
              .padding(.horizontal, 10)
            }
          )
            .buttonStyle(AwesomeButtonStyle(isSelected: selectedState))
        }
      }
    }
  }
}


