//
//  HomePresenter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/9/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

class HomePresenter: ObservableObject {
  let interactor: HomeInteractor
  let router = HomeRouter()
  
  @Published var views: Binding<Int?> = .constant(0)
  @Published var overlay: Bool = false
  @Published var errorMessage: Bool = false
  
  init(interactor: HomeInteractor) {
    self.interactor = interactor
  }
  
  func linkSpotSearchView() -> some View {
    NavigationLink(destination: router.makeSpotSearchModule(spotModel: interactor.spotModel), tag: 1, selection: views) {
      EmptyView()
    }
  }
  
  func linkDateCriteriaView() -> some View {
    NavigationLink(destination: router.makeDateCriteriaView(model: interactor.spotModel), tag: 2, selection: views) {
      EmptyView()
    }
  }
  
  func makeDateCriteriaView() -> some View {
    Button(action: {
      self.views = .constant(2)
      print(self.views)
    }, label: {
      Text("Click here to open DateCriteria")
    })
  }
  
    func makeSearch(_ query: String,_ city: String, _ state: String) -> some View {
      Button(action: {
        self.makeSearchAction(query, city, state)
      }, label: {
        Text("Click here to return search")
      })
    }
  
  func makeSearchAction(_ query: String,_ city: String, _ state: String) {
    self.overlay = true
    self.interactor.getSearchDetails(query, city, state) { (result) in
      if let error = result {
        DispatchQueue.main.async {
          print(error)
          self.overlay = false
        }
      } else if result == nil {
        DispatchQueue.main.async {
          self.views = .constant(1)
        }
      }
    }
  }

}
