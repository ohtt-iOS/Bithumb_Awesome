//
//  OrderBookDepthModel.swift
//  BithumbAwesome
//
//  Created by 강경 on 2022/03/10.
//

import SwiftUI

struct OrderBookDepthModel: Codable, Equatable {
  let quantity: String
  let price: String
}

extension OrderBookDepthModel: Identifiable {
  var id: UUID {
    return UUID()
  }
}

extension OrderBookDepthModel {
  var rectangleWidth: CGFloat {
    return CGFloat((self.quantity as NSString).floatValue)
  }
  var rectangleHeight: CGFloat {
    return 10
  }
}
