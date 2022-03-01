//
//  QuoteView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/02.
//

import ComposableArchitecture
import SwiftUI

struct QuoteView: View {
  let store: Store<QuoteState, QuoteAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      Text("Quote")
    }
  }
}
