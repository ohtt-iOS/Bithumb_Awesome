//
//  QuoteView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/02.
//

import SwiftUI
import ComposableArchitecture

struct QuoteView: View {
  let store: Store<QuoteState, QuoteAction>
  
  static let rowBlockPadding: CGFloat = 1
  private let scrollViewIdentifier: Int = 1
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      GeometryReader { geometryProxy in
        ScrollViewReader { scrollViewProxy in
          ScrollView(showsIndicators: false) {
            VStack(spacing: QuoteView.rowBlockPadding) {
              HStack(spacing: QuoteView.rowBlockPadding) {
                QuoteListRow(
                  store: Store(
                    initialState: QuoteListRowState(
                      datas: viewStore.asks,
                      closingPrice: viewStore.ticker.closingPrice,
                      openingPrice: viewStore.ticker.openingPrice
                    ),
                    reducer: quoteListRowReducer,
                    environment: ()
                  ),
                  type: OrderType.ask,
                  blockWidth: self.rowBlockWith(rowWidth: geometryProxy.size.width)
                )
                
                QuoteAdditionalInfomationList(ticker: viewStore.ticker)
                  .frame(width: self.rowBlockWith(rowWidth: geometryProxy.size.width))
                  .padding(.bottom, 10)
              }
              
              HStack(spacing: QuoteView.rowBlockPadding) {
                QuoteConclusionView(transactionData: viewStore.transactionData)
                  .frame(width: self.rowBlockWith(rowWidth: geometryProxy.size.width))
                  .padding(.top, 10)
                
                VStack {
                  QuoteListRow(
                    store: Store(
                      initialState: QuoteListRowState(
                        datas: viewStore.bids,
                        closingPrice: viewStore.ticker.closingPrice,
                        openingPrice: viewStore.ticker.openingPrice
                      ),
                      reducer: quoteListRowReducer,
                      environment: ()
                    ),
                    type: OrderType.bid,
                    blockWidth: self.rowBlockWith(rowWidth: geometryProxy.size.width)
                  )

                  Spacer()
                }
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
