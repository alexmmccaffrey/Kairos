//
//  ReviewData.swift
//  Kairos
//
//  Created by Alex McCaffrey on 3/25/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Combine

struct Review: Codable {
  var spotID: Int
  var time: Int?
  var light: Int?
  var crowd: Int?
  var chat: Int?
  
  enum CodingKeys: String, CodingKey {
    case spotID = "spot_id", time, light, crowd, chat
  }
  
  /// spotid set to 1 on init for the moment while I wait for way to determine spotid during review process

  
  init() {
    spotID = 1
    time = nil
    light = nil
    crowd = nil
    chat = nil
  }
}
