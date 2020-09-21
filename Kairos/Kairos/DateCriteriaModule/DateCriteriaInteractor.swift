//
//  File.swift
//  Kairos
//
//  Created by Alex McCaffrey on 8/25/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class DateCriteriaInteractor {
  let model: SpotModel
  let searchService: SpotFinderSearch
  
  init (model: SpotModel, searchService: SpotFinderSearch) {
    self.model = model
    self.searchService = searchService
  }
  
  func getSearchDetails(time: Int, light: Int, crowd: Int, chat: Int,_ city: String,_ state: String, searchCompletionBlock: @escaping () -> Void) {
    searchService.spotFinder(time: time, light: light, crowd: crowd, chat: chat, city, state) { (output) in
      self.model.spots = output
      searchCompletionBlock()
    }
  }
  
}
