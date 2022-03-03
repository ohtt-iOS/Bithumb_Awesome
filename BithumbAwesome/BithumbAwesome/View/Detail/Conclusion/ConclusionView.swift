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
      VStack(spacing: 0) {
        ConclusionHeaderView()
          .frame(height: 20)
          .padding(.horizontal, 14)
          .padding(.top, 14)
        
        Rectangle()
          .frame(height: 1, alignment: .center)
          .foregroundColor(Color.aGray1)
        
        ScrollView(showsIndicators: false) {
          ForEach(0..<10) { _ in
            ConclusionRowView(
              store: Store(
                initialState: ConclusionRowState(
                ),
                reducer: conclusionRowReducer,
                environment: ()
              )
            )
              .frame(height: 40)
              .padding(.horizontal, 14)
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
    }
  }
}

