//
//  ReviewCheckModel.swift
//  Kairos
//
//  Created by Alex McCaffrey on 12/17/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class ReviewCheckModel: Codable {
  
  var spotID: Int?
  var userID: Int?
    
  enum CodingKeys: String, CodingKey {
    case spotID = "spotid", userID = "userid"
  }

}

//#if DEBUG
extension ReviewCheckModel {
  static var sampleModel: ReviewCheckModel {
    let model = ReviewCheckModel()
    return model
  }
}
//#endif
