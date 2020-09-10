//
//  GPlaceData.swift
//  Kairos
//
//  Created by Alex McCaffrey on 7/13/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

struct Places: Codable {
  var places: [Place]
  
  init() {
    places = [Place()]
  }
}

struct Place: Codable {
  var spotID: Int
  var placeID: String
  var name: String
  enum CodingKeys: String, CodingKey {
    case spotID = "spotid", placeID = "gplacesid", name
  }
}

extension Place {
  init() {
    spotID = 0
    placeID = ""
    name = ""
  }
}
