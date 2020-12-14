//
//  LocationModel.swift
//  Kairos
//
//  Created by Alex McCaffrey on 11/23/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Combine
import CoreLocation
import Foundation
import SwiftUI


class LocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {
//  private let locationManager: CLLocationManager
//  let objectWillChange = ObservableObjectPublisher()
  
  @Published var location = LocationData()
  
//  @Published var city: String = ""
//  @Published var state: String = ""
  
  @Published var coordinates: CLLocationCoordinate2D?


//  init(locationManager: CLLocationManager = CLLocationManager()) {
//    self.locationManager = locationManager
//    super.init()
//  }
//
//  func checkLocation(completion: @escaping () -> Void) {
//    self.locationManager.delegate = self
//    self.locationManager.requestWhenInUseAuthorization()
//    self.locationManager.startUpdatingLocation()
//    completion()
//  }
//
//  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    currentLocation = locations.last
//    self.location.latitude = currentLocation?.coordinate.latitude
//    self.location.longitude = currentLocation?.coordinate.longitude
//    self.currentLat = currentLocation?.coordinate.latitude
//    print(self.location.latitude)
//    print(self.currentLat)
//    manager.stopUpdatingLocation()
//  }
//
//  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//    if status == .authorizedWhenInUse {
//      manager.startUpdatingLocation()
//    }
//  }

}

#if DEBUG
extension LocationModel{
  static var sampleModel: LocationModel {
    let model = LocationModel()
    return model
  }
}
#endif
