//
//  ContentView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 3/25/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import SwiftUI

struct ContentView: View {
  @State var isLoggedIn = UserDefaults.standard.bool(forKey: "IsLoggedIn")

  var body: some View {
    if isLoggedIn {
      HomeView(presenter:
        HomePresenter(interactor:
          HomeInteractor(
            locationModel: LocationModel(),
            reviewModel: ReviewModel(),
            spotModel: SpotModel(spot: Spot()),
            recentlyReviewedSpotModel: SpotModel(spot: Spot()),
            nearbySpotModel: SpotModel(spot: Spot()),
            userModel: UserLoginModel(),
            imageDownloadService: ImageDownloadService(),
            locationService: UserLocationService(),
            searchService: SpotNameSearch(),
            spotFinderService: SpotFinderSearch(),
            nearbySpotService: NearbySpots(),
            recentlyReviewedService: RecentlyReviewedSpots())))
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
    } else {
      LoginView(presenter:
        LoginPresenter(interactor:
          LoginInteractor(
            loginService: UserLoginService(),
            signUpService: UserSignUpService(),
            userModel: UserLoginModel()),
          isFromHome: false
        ))
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let locationModel = LocationModel()
    let reviewModel = ReviewModel.sampleModel
    let spotModel = SpotModel.sampleModel
    let recentlyReviewedSpotModel = SpotModel.sampleModel
    let nearbySpotModel = SpotModel.sampleModel
    let userModel = UserLoginModel.sampleModel
    let imageDownloadService = ImageDownloadService()
    let locationService = UserLocationService()
    let searchService = SpotNameSearch()
    let spotFinderService = SpotFinderSearch()
    let nearbySpotService = NearbySpots()
    let recentlyReviewedService = RecentlyReviewedSpots()
    let interactor = HomeInteractor(
      locationModel: locationModel,
      reviewModel: reviewModel,
      spotModel: spotModel,
      recentlyReviewedSpotModel: recentlyReviewedSpotModel,
      nearbySpotModel: nearbySpotModel,
      userModel: userModel,
      imageDownloadService: imageDownloadService,
      locationService: locationService,
      searchService: searchService,
      spotFinderService: spotFinderService,
      nearbySpotService: nearbySpotService,
      recentlyReviewedService: recentlyReviewedService)
    let presenter = HomePresenter(interactor: interactor)
    return HomeView(presenter: presenter)
  }
}
