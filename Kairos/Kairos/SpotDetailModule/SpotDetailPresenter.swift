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
  
  
//  func makeButtonForGetCall() -> some View {
//    Button(action: {
//      self.interactor.getSpotDetails(8) { (output) in
//        print(output)
//        DispatchQueue.main.async {
////          self.spotData.spotID = output.spotID
////          self.spotData.time = output.time
////          self.spotData.light = output.light
////          self.spotData.crowd = output.crowd
////          self.spotData.chat = output.chat
//        }
//      }
//    }, label: {
//      Text("Click here to return details")
//    })
//  }
}

