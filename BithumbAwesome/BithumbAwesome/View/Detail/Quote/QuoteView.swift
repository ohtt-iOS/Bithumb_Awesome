//
//  QuoteView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/02.
//

import ComposableArchitecture
import SwiftUI

struct QuoteView: View {
  static let rowBlockPadding: CGFloat = 1
  
  let store: Store<QuoteState, QuoteAction>
  
  private let scrollViewIdentifier: Int = 1
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      GeometryReader { geometryProxy in
        ScrollViewReader { scrollViewProxy in
          ScrollView(showsIndicators: false) {
            VStack(spacing: QuoteView.rowBlockPadding) {
              HStack(spacing: QuoteView.rowBlockPadding) {
                QuoteListRow(width: geometryProxy.size.width)
                
                QuoteAdditionalInfomationList()
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
}
