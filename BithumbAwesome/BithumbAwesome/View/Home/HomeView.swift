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
        Image.logo
          .resizable()
          .frame(width: 216, height: 61, alignment: .leading)
        Spacer()
        
        ScrollView(.horizontal, showsIndicators: false) {
          RadioButtonView(
            store: store.scope(
              state: \.radioButtonState,
              action: HomeAction.radioButtonAction
            )
          )
            .padding(.horizontal, 14)
        }
        
        HomeHeaderView()
          .frame(height: 20)
          .padding(.horizontal, 14)
          .padding(.top, 14)
        
        ScrollView(showsIndicators: false) {
          VStack(spacing: 10) {
            ForEach(viewStore.tickerData, id: \.id) { ticker in
              NavigationLink(
                destination: DetailView(store: Store(
                  initialState: DetailState(
                    naviTitle: ticker.name,
                    priceState: PriceState(
                      tickerData: ticker)),
                  reducer: detailReducer,
                  environment: DetailEnvironment(mainQueue: .main,
                                                 transactionService: .transaction)
                ))){
                  VStack {
                    TickerRowView(
                      store: Store(
                        initialState: TickerState(
                          ticker: ticker
                        ),
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
                .buttonStyle(FlatLinkStyle())
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

struct HomeHeaderView: View {
  var body: some View {
    GeometryReader { g in
      HStack(spacing: 5) {
        Text("가산자산명")
          .frame(width: g.size.width/5, alignment: .leading)
          .font(.heading6)
          .foregroundColor(Color.aGray2)
        
        Spacer()
        Text("현재가")
          .font(.heading6)
          .frame(width: g.size.width/4.5, alignment: .trailing)
          .foregroundColor(Color.aGray2)
        
        Spacer()
        Text("변동률")
          .frame(width: g.size.width/4.5, alignment: .trailing)
          .font(.heading6)
          .foregroundColor(Color.aGray2)
        
        Spacer()
        Text("거래금액")
          .frame(width: g.size.width/6, alignment: .trailing)
          .font(.heading6)
          .foregroundColor(Color.aGray2)
      }
    }
  }
}
