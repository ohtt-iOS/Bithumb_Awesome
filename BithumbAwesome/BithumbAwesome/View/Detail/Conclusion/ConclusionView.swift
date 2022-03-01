//
//  ConclusionView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/02.
//

import ComposableArchitecture
import SwiftUI

struct ConclusionView: View {
  let store: Store<ConclusionState, ConclusionAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      Text("Conclusion")
    }
  }
}
