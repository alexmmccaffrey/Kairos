//
//  SpotReviewRouter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

class SpotDetailRouter {
  
  func makeBuildReviewView(model: ReviewModel) -> some View {
    let service = BuildReviewService()
    let presenter = BuildReviewPresenter(
      interactor: BuildReviewInteractor(
        model: model, service: service))
    return BuildReviewView(presenter: presenter)
  }
  
}


