//
//  SpotReviewPresenter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Combine
import SwiftUI

class SpotReviewPresenter: ObservableObject {
  private let interactor: SpotDetailInteractor
  private let router = SpotReviewRouter()
  
  init (interactor: SpotReviewInteractor) {
    self.interactor = interactor
  }
  
  @ObservedObject var wow = interactor.model.SpotDetails.chatrating
  
  func makeButtonForGetCall() -> some View {
    Button(action: {
      self.interactor.getSpotDetails(1)
    }, label: {
      Text("Click here to return details")
    })
  }
}

