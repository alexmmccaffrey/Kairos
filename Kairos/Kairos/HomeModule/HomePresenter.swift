//
//  HomePresenter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/9/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Combine
import SwiftUI

class HomePresenter: ObservableObject {
  let interactor: HomeInteractor
  let router = HomeRouter()
  
  init(interactor: HomeInteractor) {
    self.interactor = interactor
  }
  
  @Published var queryData = Places().places

  func makeReviewBuilderButton() -> some View {
    NavigationLink(destination: router.makeBuildReviewView(model: interactor.reviewModel)) {
      Image("Versace_Logo")
    }
  }
  
  func makeSpotDetailButton() -> some View {
    NavigationLink(destination: router.makeSpotDetailView(model: interactor.spotModel)) {
      Image("WUTANG")
    }
  }
  
  func makeButtonForGetSearch(_ query: String,_ city: String, _ state: String) -> some View {
    Button(action: {
      self.interactor.getSearchDetails(query, city, state) { (output) in
        DispatchQueue.main.async {
          self.queryData[0].spotID = output[0].spotID
        }
      }
    }, label: {
      Text("Click here to return search")
    })
  }
  
}
