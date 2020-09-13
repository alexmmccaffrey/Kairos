//
//  ContentView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 3/25/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct ContentView: View {

  var body: some View {
    HomeView(presenter:
      HomePresenter(interactor:
        HomeInteractor(
          reviewModel: ReviewModel(),
          spotModel: SpotModel(spot: Spot()),
          searchService: SpotNameSearch())))
  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let reviewModel = ReviewModel.sampleModel
    let spotModel = SpotModel.sampleModel
    let searchService = SpotNameSearch()
    let interactor = HomeInteractor(reviewModel: reviewModel, spotModel: spotModel, searchService: searchService)
    let presenter = HomePresenter(interactor: interactor)
    return HomeView(presenter: presenter)
  }
}
