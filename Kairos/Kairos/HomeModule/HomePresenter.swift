//
//  HomePresenter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/9/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
  private let interactor: HomeInteractor
  private let router = HomeRouter()
  
  init(interactor: HomeInteractor) {
    self.interactor = interactor
  }

  func makeReviewBuilderButton() -> some View {
    NavigationLink(destination: router.makeBuildReviewView(model: interactor.model)) {
      Image("Versace_Logo")
    }
  }
  
  
}
