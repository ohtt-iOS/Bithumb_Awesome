//
//  ProfileLinkView.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/13.
//

import SwiftUI

struct ProfileLinkView: View {
  let type: ProfileType
  
  var body: some View {
    Link(
      destination: URL(string: self.type.urlString)!,
      label: {
        ProfileView(type: self.type)
      }
    )
  }
}
