//
//  ResponseResult.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/04.
//

import Foundation

struct ResponseResult<T: Codable>: Codable {
  var status: String?
  var data: [T]?
}

struct ResponseSimpleResult<T: Codable>: Codable {
  var status: String?
  var data: T?
}
