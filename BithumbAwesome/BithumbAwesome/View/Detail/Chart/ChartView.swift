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
        HStack(spacing: 5) {
          ForEach(0..<5) { index in
            Button(
              action: {  },
              label: { Text("\(index)") }
            )
              .frame(maxWidth: .infinity)
          }
        }
      }
    }
  }
}
