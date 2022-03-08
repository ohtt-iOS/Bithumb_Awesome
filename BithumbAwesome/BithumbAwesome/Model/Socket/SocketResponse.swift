//
//  SocketResponse.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/07.
//

import Foundation

struct SocketResponse<T: Codable>: Codable {
  var type: String?
  var content: T?
}
