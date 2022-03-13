//
//  ProfileType.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/13.
//

import SwiftUI

enum ProfileType {
  case kangkyung, ohtt
}

extension ProfileType: CaseIterable, Identifiable {
  var id: UUID {
    return UUID()
  }
}

extension ProfileType {
  var urlString: String {
    switch self {
    case .kangkyung:
      return AwesomeURL.kangkyungGithubPage
    case .ohtt:
      return AwesomeURL.ohttGithubPage
    }
  }
  var imageView: some View {
    switch self {
    case .kangkyung:
      return Image.profileKangkyung
        .resizable()
        .frame(width: 104, height: 82)
    case .ohtt:
      return Image.profileOhtt
        .resizable()
        .frame(width: 82, height: 82)
    }
  }
  var textString: String {
    switch self {
    case .kangkyung:
      return "강경 @KangKyung"
    case .ohtt:
      return "오뜨 @ohtt-iOS"
    }
  }
}
