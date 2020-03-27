//
//  ReviewData.swift
//  Kairos
//
//  Created by Alex McCaffrey on 3/25/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

///



///


struct Review {
  var time: TimeOfDayRating
  var light: LightRating
  var crowd: CrowdRating
  var talkable: TalkableRating
}

extension Review {
  init() {
    time = TimeOfDayRating.null
    light = LightRating.null
    crowd = CrowdRating.null
    talkable = TalkableRating.null
  }
}

extension Review {
  enum TimeOfDayRating: String, CaseIterable {
    case morning
    case noon
    case afternoon
    case evening
    case lateNight
    case null
  }
  enum LightRating: CaseIterable {
    case glimmering
    case bright
    case moody
    case dark
    case null
  }
  enum CrowdRating: CaseIterable {
    case relaxed
    case lively
    case excited
    case null
  }
  enum TalkableRating: CaseIterable {
    case greatconvo
    case loud
    case quiet
    case null
  }
}

