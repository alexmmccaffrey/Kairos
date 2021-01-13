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
  
  func getNumberOfSpotsInSearch() -> Int {
    return self.spots?.count ?? 0
  }
  
  func getLightRating(time: Int) -> String {
    if time == 1 {
      let light = spot.lightTime1
      if light == 1 {
        return "Dim"
      } else if light == 2 {
        return "Soft"
      } else if light == 3 {
        return "Bright"
      } else if light == 4 {
        return "Vibrant"
      }
    } else if time == 2 {
      let light = spot.lightTime2
      if light == 1 {
        return "Dim"
      } else if light == 2 {
        return "Soft"
      } else if light == 3 {
        return "Bright"
      } else if light == 4 {
        return "Vibrant"
      }
    } else if time == 3 {
      let light = spot.lightTime3
      if light == 1 {
        return "Dim"
      } else if light == 2 {
        return "Soft"
      } else if light == 3 {
        return "Bright"
      } else if light == 4 {
        return "Vibrant"
      }
    } else if time == 4 {
      let light = spot.lightTime4
      if light == 1 {
        return "Dim"
      } else if light == 2 {
        return "Soft"
      } else if light == 3 {
        return "Bright"
      } else if light == 4 {
        return "Vibrant"
      }
    }
    return "N/A"
  }
  
  func getCrowdRating(crowd: Int) -> String {
    if crowd == 1 {
      let crowd = spot.crowdTime1
      if crowd == 1 {
        return "Exclusive"
      } else if crowd == 2 {
        return "Quaint"
      } else if crowd == 3 {
        return "Popular"
      } else if crowd == 4 {
        return "Packed"
      }
    } else if crowd == 2 {
      let crowd = spot.crowdTime2
      if crowd == 1 {
        return "Exclusive"
      } else if crowd == 2 {
        return "Quaint"
      } else if crowd == 3 {
        return "Popular"
      } else if crowd == 4 {
        return "Packed"
      }
    } else if crowd == 3 {
      let crowd = spot.crowdTime3
      if crowd == 1 {
        return "Exclusive"
      } else if crowd == 2 {
        return "Quaint"
      } else if crowd == 3 {
        return "Popular"
      } else if crowd == 4 {
        return "Packed"
      }
    } else if crowd == 4 {
      let crowd = spot.crowdTime4
      if crowd == 1 {
        return "Exclusive"
      } else if crowd == 2 {
        return "Quaint"
      } else if crowd == 3 {
        return "Popular"
      } else if crowd == 4 {
        return "Packed"
      }
    }
    return "N/A"
  }
  
  func getChatRating(chat: Int) -> String {
    if chat == 1 {
      let chat = spot.chatTime1
      if chat == 1 {
        return "Silent"
      } else if chat == 2 {
        return "Talkative"
      } else if chat == 3 {
        return "Poppin'"
      } else if chat == 4 {
        return "Loud"
      }
    } else if chat == 2 {
      let chat = spot.chatTime2
      if chat == 1 {
        return "Silent"
      } else if chat == 2 {
        return "Talkative"
      } else if chat == 3 {
        return "Poppin'"
      } else if chat == 4 {
        return "Loud"
      }
    } else if chat == 3 {
      let chat = spot.chatTime3
      if chat == 1 {
        return "Silent"
      } else if chat == 2 {
        return "Talkative"
      } else if chat == 3 {
        return "Poppin'"
      } else if chat == 4 {
        return "Loud"
      }
    } else if chat == 4 {
      let chat = spot.chatTime4
      if chat == 1 {
        return "Silent"
      } else if chat == 2 {
        return "Talkative"
      } else if chat == 3 {
        return "Poppin'"
      } else if chat == 4 {
        return "Loud"
      }
    }
    return "N/A"
  }
  
  
}

//#if DEBUG
extension SpotModel {
  static var sampleModel: SpotModel {
    let model = SpotModel(spot: Spot())
    return model
  }
}
//#endif
