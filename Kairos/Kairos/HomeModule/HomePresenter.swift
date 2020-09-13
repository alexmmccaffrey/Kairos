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


  func makeReviewBuilderButton() -> some View {
    NavigationLink(destination: router.makeBuildReviewView(model: interactor.reviewModel)) {
      Text("Review Builder")
      Image("Versace_Logo")
    }
  }
  
  func makeSpotDetailButton() -> some View {
    NavigationLink(destination: router.makeSpotDetailView(model: self.interactor.spotModel)) {
      Text("Spot Detail")
      Image("WUTANG")
    }
  }
  
  func makeSpotSearchButton() -> some View {
    NavigationLink(destination: router.makeSpotSearchModule(spotModel: self.interactor.spotModel)) {
        Text("Spot Detail")
        Image("PVC_Pipes")
    }
  }
  
  @Published var spots: [Spot]?
  
  func makeSearch(_ query: String,_ city: String, _ state: String) -> some View {
    Button(action: {
      self.interactor.getSearchDetails(query, city, state) {
        self.spots = self.interactor.spotModel.spots
      }
    }, label: {
      Text("Click here to return search")
    })
  }
  
//  func makeButtonForGetSearch(_ query: String,_ city: String, _ state: String) -> some View {
//    Button(action: {
//      self.interactor.getSearchDetails(query, city, state) { (output) in
//        DispatchQueue.main.async {
//          self.places = output
//        }
//      }
//    }, label: {
//      Text("Click here to return search")
//    })
//  }
  

  
}
