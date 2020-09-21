//
//  SpotReviewPresenter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import SwiftUI

class SpotDetailPresenter: ObservableObject {
  let interactor: SpotDetailInteractor
  let router = SpotDetailRouter()
  
  init (interactor: SpotDetailInteractor) {
    self.interactor = interactor
  }
  
  @Published var spotData: Spot?
  
  func make() {
    spotData = self.interactor.model.spot
  }
  
  func makeBuildReviewView() -> some View {
    NavigationLink(destination: router.makeBuildReviewView(model: ReviewModel())) {
      VStack {
        Text("Build Review Button")
      }
    }
  }

}

