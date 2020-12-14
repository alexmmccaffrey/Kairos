//
//  DateCriteriaPresenter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 8/25/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

class DateCriteriaPresenter: ObservableObject {
  let interactor: DateCriteriaInteractor
  let router = DateCriteriaRouter()
  
  @Published var views: Binding<Int?> = .constant(0)
  @Published var overlay: Bool = false
  
  init(interactor: DateCriteriaInteractor) {
    self.interactor = interactor
  }
  
  func makeSpotSearchView() -> some View {
//    NavigationLink(destination: router.makeSpotSearchModule(spotModel: interactor.model), tag: 1, selection: views) {
//      EmptyView()
//    }
    EmptyView()
  }
  
  func makeSearch(time: Int, light: Int, crowd: Int, chat: Int, _ city: String,_ state: String) {
    self.overlay = true
    self.interactor.getSearchDetails(time: time, light: light, crowd: crowd, chat: chat, city, state) { (result) in
      if let error = result {
        DispatchQueue.main.async {
          print(error)
        }
      } else if result == nil {
        DispatchQueue.main.async {
          self.views = .constant(1)
        }
      }
    }
  }
  
  func makeSearchButton() -> some View {
    Button(action: {
      self.makeSearch(time: 1, light: 5, crowd: 5, chat: 5, "Santa Monica", "California")
    }, label: {
      Text("Click here to return search")
    })
  }

}
