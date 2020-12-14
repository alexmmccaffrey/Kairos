//
//  HomeViewInteractor.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/9/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Combine
import CoreLocation
import Foundation
import SwiftUI

class HomeInteractor: NSObject, ObservableObject, CLLocationManagerDelegate {
  
  @ObservedObject var locationModel: LocationModel
  let reviewModel: ReviewModel
  let spotModel: SpotModel
  let userModel: UserLoginModel
  let imageDownloadService: ImageDownloadService
  let locationService: UserLocationService
  let searchService: SpotNameSearch
  let spotFinderService: SpotFinderSearch
  
  private let locationManager: CLLocationManager
  
//  var anyCancellable: AnyCancellable? = nil
  @Published var city: String = "Santa Monica"
  @Published var state: String = "California"
  @Published var isError: Bool = false
  
  /// Check this in the future to fix this location architecture issue https://stackoverflow.com/questions/58406287/how-to-tell-swiftui-views-to-bind-to-nested-observableobjects

  init (locationModel: LocationModel, reviewModel: ReviewModel, spotModel: SpotModel, userModel: UserLoginModel, imageDownloadService: ImageDownloadService, locationService: UserLocationService, searchService: SpotNameSearch, spotFinderService: SpotFinderSearch, locationManager: CLLocationManager = CLLocationManager()) {
//    self.anyCancellable = self.locationModel.objectWillChange.sink { [self] (_) in
//      self?.objectWillChange.send()
//    }
    self.locationModel = locationModel
    self.reviewModel = reviewModel
    self.spotModel = spotModel
    self.userModel = userModel
    self.imageDownloadService = imageDownloadService
    self.locationService = locationService
    self.searchService = searchService
    self.spotFinderService = spotFinderService
    self.locationManager = locationManager
    super.init()
  }

  
  func checkLocation() {
    self.locationManager.delegate = self
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if locations.isEmpty == false {
      self.locationModel.location.latitude = locations.last?.coordinate.latitude
      self.locationModel.location.longitude = locations.last?.coordinate.longitude
      self.locationModel.coordinates = locations.last?.coordinate
      self.city = "This is city"
      self.state = "This is state"
      print(self.city)
//      self.getUserLocation()
      print(self.locationModel.location.latitude!)
      print(self.locationModel.location.longitude!)
    }
    self.locationManager.stopUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
      manager.startUpdatingLocation()
    }
  }
  
  func getUserLocation() {
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let locationData = try encoder.encode(locationModel.location)
      locationService.getUserLocation(data: locationData) { (result) in
        switch result {
          case .success(let location):
            self.locationModel.location.city = location.city
            self.locationModel.location.state = location.state
            self.city = location.city ?? ""
            self.state = location.state ?? ""
          case.failure(let error):
            self.isError = true
            print(error)
        }
      }
    } catch {
      self.isError = true
      print(error)
    }
  }
  
  func getSearchDetails(_ query: String, completion: @escaping (Error?) -> Void) {
    searchService.searchPlaces(query, self.city, self.state) { (result) in
      switch result {
      case .success(let spots):
        self.spotModel.spots = spots
        completion(nil)
      case .failure(let error):
        self.spotModel.spots = nil
        completion(error)
      }
    }
  }
  
  func getSpotFinderSearchDetails(time: Int, light: Int, crowd: Int, chat: Int, completion: @escaping (Error?) -> Void) {
    spotFinderService.spotFinder(time: time, light: light, crowd: crowd, chat: chat, self.city, self.state) { (result) in
      switch result {
      case .success(let spots):
        self.spotModel.spots = spots
        completion(nil)
      case .failure(let error):
        self.spotModel.spots = nil
        completion(error)
      }
    }
  }
  
  func manageSpotImages(completion: @escaping () -> Void) {
    for i in 0..<self.spotModel.spots!.count {
      self.getSpotImageService(imageUrl: self.spotModel.spots?[i].imageURL ?? "") { (result) in
          self.spotModel.spots![i].image = result
        if i == self.spotModel.spots!.count - 1 {
          completion()
        }
      } failure: { (result) in
        print("fuck we failed that shit bitch damn")
        if i == self.spotModel.spots!.count - 1 {
          completion()
        }
      }
    }
  }
  
  func getSpotImageService(imageUrl: String, success: @escaping (UIImage) -> Void, failure: @escaping (Error) -> Void) {
    imageDownloadService.imageDownload(imageUrl: imageUrl) { (result) in
      switch result {
      case .success(let image):
        print(image)
        success(image)
      case .failure(let error):
        failure(error)
      }
    }
  }
  
}
