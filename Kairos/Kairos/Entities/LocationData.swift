//
//  LocationData.swift
//  Kairos
//
//  Created by Alex McCaffrey on 11/23/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationData: Codable {
    
  var city: String? = nil
  var state: String? = nil
  
  var latitude: Double? = nil
  var longitude: Double? = nil
  
}
