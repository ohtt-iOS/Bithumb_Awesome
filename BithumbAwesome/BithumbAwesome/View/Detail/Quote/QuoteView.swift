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
  
  private let scrollViewIdentifier: Int = 1
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      ScrollViewReader { scrollViewProxy in
        ScrollView(showsIndicators: false) {
          VStack(spacing: 1) {
            ForEach(0..<100) { index in
              Text("QuoteListRow\(index)")
            }
          }
          .id(self.scrollViewIdentifier)
        }
        .onAppear {
          scrollViewProxy.scrollTo(self.scrollViewIdentifier, anchor: .center)
        }
      }
    }
  }
}
