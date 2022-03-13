//
//  SettingView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/02/26.
//

import SwiftUI
import ComposableArchitecture

struct SettingView: View {
  var body: some View {
    VStack(spacing: 20) {
      LogoImageView()
      
      NavigationLink(
        destination: OpenSourceLibraryView(),
        label: {
          SettingButtonView(type: .license)
        }
      )
      
      Link(
        destination: URL(string: AwesomeURL.notionPage)!,
        label: {
          SettingButtonView(type: .notion)
        }
      )
      
      HStack(spacing: 20) {
        ForEach(ProfileType.allCases) { profileType in
          ProfileLinkView(type: profileType)
        }
      }
      
      Spacer()
    }
    .padding(.horizontal, 20)
  }
}
