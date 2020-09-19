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
  
  @Published var spots: [Spot]?
  @Published var views: Binding<Int?> = .constant(1)
  
//  init?(_ base: Binding<Value?>)
  
  let navigationViews = PassthroughSubject<HomePresenter,Never>()
  var currentNavigation: Int = 0 {
    didSet {
      navigationViews.send(self)
    }
  }
  
  init(interactor: HomeInteractor) {
    self.interactor = interactor
  }
  
  func makeReviewBuilderButton() -> some View {
    NavigationLink(destination: router.makeBuildReviewView(model: interactor.reviewModel)) {
      VStack {
        Text("Review Builder")
        Image("Versace_Logo")
      }
    }
  }

  func makeSpotDetailButton() -> some View {
    NavigationLink(destination: router.makeSpotDetailView(model: interactor.spotModel)) {
      VStack{
        Text("Spot Details")
        Image("PVC_Pipes")
      }
    }
  }

  func makeSpotSearchButton() -> some View {
    NavigationLink(destination: router.makeSpotSearchModule(spotModel: interactor.spotModel), tag: 2, selection: views) {
      VStack{
        Text("Spot Search View")
      }
    }
  }

  func makeSearch(_ query: String,_ city: String, _ state: String) -> some View {
    Button(action: {
      self.interactor.getSearchDetails(query, city, state) {
        DispatchQueue.main.async {
          self.spots = self.interactor.spotModel.spots
          self.views = .constant(2)
          print(self.interactor.spotModel.spots)
          print(self.views)
        }
      }
    }, label: {
      Text("Click here to return search")
    })
  }

}
