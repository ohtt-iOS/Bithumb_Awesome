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
      Text("chart")
    }
  }
}


