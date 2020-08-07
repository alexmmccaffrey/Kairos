//
//  GPlaceModel.swift
//  Kairos
//
//  Created by Alex McCaffrey on 7/13/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

final class PlacesModel {
  
  var places = Places()
  
}


#if DEBUG
extension PlacesModel {
  static var sampleModel: PlacesModel {
    let model = PlacesModel()
    return model
  }
}
#endif

