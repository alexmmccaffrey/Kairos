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
  let searchService: SpotNameSearch

  init (reviewModel: ReviewModel, spotModel: SpotModel, searchService: SpotNameSearch) {
    self.reviewModel = reviewModel
    self.spotModel = spotModel
    self.searchService = searchService
  }
  
  func getSearchDetails(_ query: String,_ city: String,_ state: String, searchCompletionBlock: @escaping () -> Void) {
    searchService.searchPlaces(query, city, state) { (output) in
      self.spotModel.spots = output
    }
  }
  
}
