//
//  HomeViewInteractor.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/9/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Combine

class HomeInteractor {
  let reviewModel: ReviewModel
  let spotModel: SpotModel
  let placesModel: PlacesModel
  let searchService: SpotNameSearch

  init (reviewModel: ReviewModel, spotModel: SpotModel, placesModel: PlacesModel, searchService: SpotNameSearch) {
    self.reviewModel = reviewModel
    self.spotModel = spotModel
    self.placesModel = placesModel
    self.searchService = searchService
  }

  func getSearchDetails(_ query: String,_ city: String,_ state: String, completion: @escaping ([Place]) -> Void) {
    searchService.searchPlaces(query, city, state) { (output) in
      completion(output)
    }
  }
}
