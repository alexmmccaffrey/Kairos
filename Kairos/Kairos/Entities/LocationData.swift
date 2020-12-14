//
//  LocationData.swift
//  Kairos
//
//  Created by Alex McCaffrey on 11/23/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Codable {
    
  var latitude: Double?
  var longitude: Double?
  var city: String?
  var state: String?
  
  init(location: CLLocationCoordinate2D, city: String, state: String) {
    latitude =  location.latitude
    longitude =  location.longitude
    self.city = city
  }
  
}
