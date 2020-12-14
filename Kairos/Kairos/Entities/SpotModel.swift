//
//  SpotModel.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import SwiftUI



final class SpotModel: ObservableObject {
  
  @Published var spot: Spot
  
  @Published var spots: [Spot]?
  
  init(spot: Spot) {
    self.spot = spot
  }
  
  func getSpotName() -> String {
    return self.spot.name
  }
  
  func getSpotAddress() -> String {
    return self.spot.address ?? "No address found"
  }
  
  func getSpotImage() -> UIImage? {
    return self.spot.image
  }
  
  func getLightRating(time: Int) -> String {
    if time == 1 {
      let light = spot.lightTime1
      return "It's \(light))"
    } else if time == 2 {
      let light = spot.lightTime2
      return "It's \(light))"
    } else if time == 3 {
      let light = spot.lightTime3
      return "It's \(light))"
    } else if time == 4 {
      let light = spot.lightTime4
      return "It's \(light))"
    } else {
      return "Not Found"
    }
  }
  
  func getCrowdRating(time: Int) -> String {
    if time == 1 {
      let crowd = spot.crowdTime1
      return "It's \(crowd))"
    } else if time == 2 {
      let crowd = spot.crowdTime2
      return "It's \(crowd))"
    } else if time == 3 {
      let crowd = spot.crowdTime3
      return "It's \(crowd))"
    } else if time == 4 {
      let crowd = spot.crowdTime4
      return "It's \(crowd))"
    } else {
      return "Not Found"
    }
  }
  
  func getChatRating(time: Int) -> String {
    if time == 1 {
      let chat = spot.chatTime1
      return "It's \(chat))"
    } else if time == 2 {
      let chat = spot.chatTime2
      return "It's \(chat))"
    } else if time == 3 {
      let chat = spot.chatTime3
      return "It's \(chat))"
    } else if time == 4 {
      let chat = spot.chatTime4
      return "It's \(chat))"
    } else {
      return "Not Found"
    }
  }
  
}

extension SpotModel {
  
  enum CrowdRating: String {
    case Low = "Low"
    case Medium = "Medium"
    case High = "High"
    case VeryHigh = "Very High"
    
    
  }
  
  
  
}


#if DEBUG
extension SpotModel {
  static var sampleModel: SpotModel {
    let model = SpotModel(spot: Spot())
    return model
  }
}
#endif
