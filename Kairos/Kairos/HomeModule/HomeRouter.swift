//
//  HomeRouter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/7/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

class HomeRouter {
  
  func makeBuildReviewView(model: ReviewModel) -> some View {
    let service = BuildReviewService()
    let presenter = BuildReviewPresenter(
      interactor: BuildReviewInteractor(
        model: model, service: service))
    return BuildReviewView(presenter: presenter)
  }
}
