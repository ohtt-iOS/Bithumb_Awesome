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
                QuoteListRow(
                  type: QuoteOrderType.ask,
                  blockWidth: self.rowBlockWith(rowWidth: geometryProxy.size.width)
                )
                
                QuoteAdditionalInfomationList()
                  .frame(width: self.rowBlockWith(rowWidth: geometryProxy.size.width))
              }
              
              HStack(spacing: QuoteView.rowBlockPadding) {
                Spacer()
                  .frame(width: self.rowBlockWith(rowWidth: geometryProxy.size.width))
                
                QuoteListRow(
                  type: QuoteOrderType.bid,
                  blockWidth: self.rowBlockWith(rowWidth: geometryProxy.size.width)
                )
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
  
  private func rowBlockWith(rowWidth: CGFloat) -> CGFloat {
    (rowWidth - (QuoteView.rowBlockPadding * 2)) / 3
  }
}
