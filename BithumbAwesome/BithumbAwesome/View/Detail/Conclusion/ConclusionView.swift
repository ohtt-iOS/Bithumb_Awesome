//
//  ConclusionView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/02.
//

import SwiftUI
import ComposableArchitecture

struct ConclusionView: View {
  let store: Store<ConclusionState, ConclusionAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(spacing: 0) {
        ConclusionHeaderView()
          .frame(height:40)
          .background(Color.aGray1)
          .padding(.top, 14)
        
        Rectangle()
          .frame(height: 1, alignment: .center)
          .foregroundColor(Color.aGray1)
        
        
        ScrollView(showsIndicators: false) {
          VStack(spacing: 0) {
            ForEach(viewStore.transactionData, id: \.id) { transaction in
              ConclusionRowView(
                store: Store(
                  initialState: ConclusionRowState(
                    ticker: viewStore.ticker,
                    data: transaction
                  ),
                  reducer: conclusionRowReducer,
                  environment: ()
                )
              )
                .frame(height: 50)
                .padding(.horizontal, 14)
            }
          }
        }
      }
    }
  }
}

struct ConclusionHeaderView: View {
  var body: some View {
    GeometryReader { g in
      HStack() {
        Text("시간")
          .frame(width: g.size.width/6, alignment: .center)
          .font(.heading6)
          .foregroundColor(Color.aGray2)
        
        Spacer()
        Text("가격")
          .font(.heading6)
          .frame(width: g.size.width/3.5, alignment: .center)
          .foregroundColor(Color.aGray2)
        
        Spacer()
        Text("체결량")
          .frame(width: g.size.width/3.5, alignment: .center)
          .font(.heading6)
          .foregroundColor(Color.aGray2)
      }
      .frame(maxHeight: .infinity)
      .padding(.horizontal, 14)
    }
  }
}
