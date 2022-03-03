//
//  HomeView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
  let store: Store<HomeState, HomeAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(alignment: .leading) {
        HStack {
          Image.logo
            .resizable()
            .frame(width: 216, height: 61, alignment: .leading)
          Spacer()
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
          RadioButtonView(
            store: store.scope(
              state: \.radioButtonState,
              action: HomeAction.radioButtonAction
            )
          )
            .padding(.horizontal, 14)
        }
        
        ScrollView(showsIndicators: false) {
          VStack(spacing: 10) {
            ForEach(0..<10) { _ in
              NavigationLink(
                destination: DetailView(store: Store(
                  initialState: DetailState(),
                  reducer: detailReducer,
                  environment: DetailEnvironment()
                ))){
                  VStack {
                    TickerRowView(
                      store: Store(
                        initialState: TickerState(),
                        reducer: tickerReducer,
                        environment: ()
                      )
                    )
                      .frame(height: 40)
                      .padding(.horizontal, 14)
                    Rectangle()
                      .frame(height: 1, alignment: .center)
                      .foregroundColor(Color.aGray1)
                  }
                }
            }
          }
          .padding(.top, 14)
          .padding(.bottom, 80)
        }
        .frame(maxWidth: .infinity)
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(store: Store(
      initialState: HomeState(),
      reducer: homeReducer,
      environment: HomeEnvironment()
    ))
  }
}
