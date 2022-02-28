//
//  AwesomeTabBarStyle.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/27.
//

import SwiftUI
import TabBar

struct AwesomeTabBarStyle: TabBarStyle {
  public func tabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
    itemsContainer()
      .background(Color.aGray1)
      .cornerRadius(25.0)
      .frame(height: 50.0)
      .padding(.horizontal, 64.0)
      .padding(.bottom, 16.0 + geometry.safeAreaInsets.bottom)
  }
}
