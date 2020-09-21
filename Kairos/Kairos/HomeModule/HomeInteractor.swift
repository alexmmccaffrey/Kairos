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
  
  func getSearchDetails(_ query: String,_ city: String,_ state: String, completion: @escaping (Error?) -> Void) {
      searchService.searchPlaces(query, city, state) { (result) in
      switch result {
        case .success(let spots):
          self.spotModel.spots = spots
          print("What the fuck")
          completion(nil)
        case .failure(let error):
          self.spotModel.spots = nil
          completion(error)
      }
    }
  }
  
}
