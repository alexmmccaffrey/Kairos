//
//  SpotData.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import SwiftUI

struct Spot: Codable {
  
  var spotID: Int
  var placeID: String
  var name: String
  var category: String?
  var address: String?
//  var imageURL: String? = "https://preview.redd.it/rxgonieqaz361.jpg?width=750&auto=webp&s=b6d0aa388438582c093a4aef94bfd34375fd4794"
  var imageID: String?
  var image: UIImage?
  var lightTime1: Int?
  var crowdTime1: Int?
  var chatTime1: Int?
  var lightTime2: Int?
  var crowdTime2: Int?
  var chatTime2: Int?
  var lightTime3: Int?
  var crowdTime3: Int?
  var chatTime3: Int?
  var lightTime4: Int?
  var crowdTime4: Int?
  var chatTime4: Int?
  
  
  enum CodingKeys: String, CodingKey {
    case spotID = "spot_id", placeID = "tomtom_id", name, category, address, imageID = "photoId", lightTime1 = "light_time1", crowdTime1 = "crowd_time1", chatTime1 = "chat_time1", lightTime2 = "light_time2", crowdTime2 = "crowd_time2", chatTime2 = "chat_time2", lightTime3 = "light_time3", crowdTime3 = "crowd_time3", chatTime3 = "chat_time3", lightTime4 = "light_time4", crowdTime4 = "crowd_time4", chatTime4 = "chat_time4"
  }
  
  /// spotid set to 0 on init for the moment while I wait for way to determine spotid during review process

  
  init() {
    spotID = 0
    placeID = ""
    name = ""
  }
}

// Conforming Spot to Identifiable
extension Spot: Identifiable {
    var id: Int { return spotID }
}
