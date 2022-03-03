//
//  AssetResponse.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/03.
//

import Foundation

struct AssetData: Codable, Equatable {
  let withdrawalStatus: Int?
  let depositStatus: Int?
  
  enum CodingKeys: String, CodingKey {
    case withdrawalStatus = "withdrawal_status"
    case depositStatus = "deposit_status"
  }
}
