//
//  HomeViewInteractor.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/9/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import CoreLocation
import Foundation
import SwiftUI
import Combine

class HomeInteractor: NSObject, ObservableObject, CLLocationManagerDelegate {  
  var locationModel: LocationModel
  let reviewModel: ReviewModel
  let spotModel: SpotModel
  let recentlyReviewedSpotModel: SpotModel
  let nearbySpotModel: SpotModel
  let userModel: UserLoginModel
  let imageDownloadService: ImageDownloadService
  let locationService: UserLocationService
  let searchService: SpotNameSearch
  let spotFinderService: SpotFinderSearch
  let nearbySpotService: NearbySpots
  let recentlyReviewedService: RecentlyReviewedSpots
  
  private let locationManager: CLLocationManager
  
  let defaults = UserDefaults.standard
  
  @Published var isBroken: Bool = true
  @Published var viewCity: String = ""
  @Published var viewState: String = ""
  @Published var city: String = ""
  @Published var state: String = ""
  @Published var isError: Bool = false
  var isLocationApplied: Bool {
    city != "" && state != ""
  }
  
  
  func getLoggedInStatus() -> Bool {
    return userModel.getLoggedInStatus()
  }
  
  /// Check this in the future to fix this location architecture issue https://stackoverflow.com/questions/58406287/how-to-tell-swiftui-views-to-bind-to-nested-observableobjects

  init (locationModel: LocationModel, reviewModel: ReviewModel, spotModel: SpotModel, recentlyReviewedSpotModel: SpotModel, nearbySpotModel: SpotModel, userModel: UserLoginModel, imageDownloadService: ImageDownloadService, locationService: UserLocationService, searchService: SpotNameSearch, spotFinderService: SpotFinderSearch, nearbySpotService: NearbySpots, recentlyReviewedService: RecentlyReviewedSpots, locationManager: CLLocationManager = CLLocationManager()) {
    self.locationModel = locationModel
    self.reviewModel = reviewModel
    self.spotModel = spotModel
    self.recentlyReviewedSpotModel = recentlyReviewedSpotModel
    self.nearbySpotModel = nearbySpotModel
    self.userModel = userModel
    self.imageDownloadService = imageDownloadService
    self.locationService = locationService
    self.searchService = searchService
    self.spotFinderService = spotFinderService
    self.locationManager = locationManager
    self.nearbySpotService = nearbySpotService
    self.recentlyReviewedService = recentlyReviewedService
    super.init()
  }

  func logout() {
    userModel.logout()
    self.defaults.set(nil, forKey: "AccessToken")
    self.defaults.set(nil, forKey: "RefreshToken")
    self.defaults.set(nil, forKey: "UserID")
    self.defaults.set(nil, forKey: "Username")
    self.defaults.set(false, forKey: "IsLoggedIn")
  }
  
  func getUserName() -> String {
    return userModel.getUserName()
  }
  
  func getCity() -> String {
    return self.city
  }
  
  func getState() -> String {
    return self.state
  }
  
  func getAreSpotsReturnedInSearch() -> Bool {
    return spotModel.getNumberOfSpotsInSearch() > 0
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
      print(locations)
    }
    self.locationManager.stopUpdatingLocation()
    self.getUserLocation()
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
            DispatchQueue.main.async {
              self.city = location.city ?? ""
              self.state = location.state ?? ""
              self.viewCity = location.city ?? ""
              self.viewState = location.state ?? ""
            }
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
  
  func getNearbySpots(success: @escaping (NearbySpotsResponse?) -> Void, failure: @escaping (Error?) -> Void) {
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let locationData = try encoder.encode(locationModel.location)
      nearbySpotService.getNearbySpots(data: locationData) { (result) in
        switch result {
          case .success(let spots):
            self.nearbySpotModel.spots = spots
            success(nil)
          case .failure(let error):
            ///
            let spots = [Spot(), Spot(), Spot(), Spot(), Spot(), Spot(), Spot()]
            self.nearbySpotModel.spots = spots
            ///
            failure(error)
        }
      }
    } catch {
      failure(error)
    }
  }
  
  func getRecentlyReviewedSpots(success: @escaping (RecentlyReviewedSpotsResponse?) -> Void, failure: @escaping (Error?) -> Void) {
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let locationData = try encoder.encode(locationModel.location)
      recentlyReviewedService.getRecentlyReviewed(city: "Centennial", state: "CO") { (result) in
        switch result {
          case .success(let spots):
            self.recentlyReviewedSpotModel.spots = spots
            success(nil)
          case .failure(let error):
            ///
            let spots = [Spot(), Spot(), Spot(), Spot(), Spot()]
            self.recentlyReviewedSpotModel.spots = spots
            ///
            failure(error)
        }
      }
    } catch {
      failure(error)
    }
  }
  
  func getSearchDetails(_ query: String, completion: @escaping (Error?) -> Void) {
    searchService.searchPlaces(query, self.city, self.state) { (result) in
      switch result {
      case .success(let spots):
        print(spots)
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
        print(spots)
        self.spotModel.spots = spots
        completion(nil)
      case .failure(let error):
        self.spotModel.spots = nil
        completion(error)
      }
    }
  }
  
  func manageSpotImages(completion: @escaping () -> Void) {
    for i in 0..<(self.spotModel.spots?.count ?? 0) {
      self.getSpotImageService(imageID: self.spotModel.spots?[i].imageID ?? "") { (result) in
          self.spotModel.spots![i].image = result
        if i == self.spotModel.spots!.count - 1 {
          completion()
        }
      } failure: { (result) in
        if i == self.spotModel.spots!.count - 1 {
          completion()
        }
      }
    }
  }
  
  func getSpotImageService(imageID: String, success: @escaping (UIImage) -> Void, failure: @escaping (Error) -> Void) {
    imageDownloadService.imageDownload(imageID: imageID) { (result) in
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
