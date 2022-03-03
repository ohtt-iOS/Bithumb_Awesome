//
//  Asset.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/02.
//

import Foundation

struct Asset: Codable {
  let ticker: String
  let data: AssetData
}

extension Asset {
  var name: String {
    return self.ticker
  }
}

extension Asset: Equatable, Identifiable {
  var id: UUID {
   UUID()
  }
}
