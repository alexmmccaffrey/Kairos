//
//  SpotData.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Combine

struct Spot: Codable {
  var spotid: Int
  var time: Int
  var light: Int
  var crowd: Int
  var chat: Int
  
  
  
  /// spotid set to 0 on init for the moment while I wait for way to determine spotid during review process
  
  init() {
    spotid = 0
    time = 0
    light = 0
    crowd = 0
    chat = 0
  }
}
