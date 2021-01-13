//
//  ReviewData.swift
//  Kairos
//
//  Created by Alex McCaffrey on 3/25/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

struct Review: Codable {
  var spotID: Int?
  var userID: Int?
  var time: Int?
  var light: Int?
  var crowd: Int?
  var chat: Int?
  var success: Bool?
  
  enum CodingKeys: String, CodingKey {
    case spotID = "spotid", userID = "userid", time, light, crowd, chat, success
  }
  
  /// spotid set to 1 on init for the moment while I wait for way to determine spotid during review process

  
  init() {
    spotID = nil
    userID = nil
    time = nil
    light = nil
    crowd = nil
    chat = nil
    success = nil
  }
}
