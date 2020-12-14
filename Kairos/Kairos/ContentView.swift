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
//    VStack {
      if isLoggedIn {
        HomeView(presenter:
          HomePresenter(interactor:
            HomeInteractor(
              locationModel: LocationModel(),
              reviewModel: ReviewModel(),
              spotModel: SpotModel(spot: Spot()),
              userModel: UserLoginModel(),
              imageDownloadService: ImageDownloadService(),
              locationService: UserLocationService(),
              searchService: SpotNameSearch(),
              spotFinderService: SpotFinderSearch())))
          .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
      } else {
        LoginView(presenter:
          LoginPresenter(interactor:
            LoginInteractor(
              loginService: UserLoginService(),
              signUpService: UserSignUpService(),
              userModel: UserLoginModel())))
          .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
      }
//    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let locationModel = LocationModel()
    let reviewModel = ReviewModel.sampleModel
    let spotModel = SpotModel.sampleModel
    let userModel = UserLoginModel.sampleModel
    let imageDownloadService = ImageDownloadService()
    let locationService = UserLocationService()
    let searchService = SpotNameSearch()
    let spotFinderService = SpotFinderSearch()
    let interactor = HomeInteractor(
      locationModel: locationModel,
      reviewModel: reviewModel,
      spotModel: spotModel,
      userModel: userModel,
      imageDownloadService: imageDownloadService,
      locationService: locationService,
      searchService: searchService,
      spotFinderService: spotFinderService)
    let presenter = HomePresenter(interactor: interactor)
    return HomeView(presenter: presenter)
  }
}
