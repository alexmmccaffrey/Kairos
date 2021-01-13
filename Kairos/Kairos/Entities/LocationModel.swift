//
//  LocationModel.swift
//  Kairos
//
//  Created by Alex McCaffrey on 11/23/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import CoreLocation
import Foundation
import SwiftUI


class LocationModel: ObservableObject {
  
  @Published var location = LocationData()
  
  @Published var coordinates: CLLocationCoordinate2D?


}

//#if DEBUG
extension LocationModel{
  static var sampleModel: LocationModel {
    let model = LocationModel()
    return model
  }
}
//#endif
