//
//  ReviewData.swift
//  Kairos
//
//  Created by Alex McCaffrey on 3/25/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Combine

struct Review: Codable {
  var time: Int?
  var light: Int?
  var crowd: Int?
  var chat: Int?
  
  init() {
    time = nil
    light = nil
    crowd = nil
    chat = nil
  }
}
