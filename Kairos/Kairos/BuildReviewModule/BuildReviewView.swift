//
//  BuildReviewView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/7/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct BuildReviewView: View {
  
  @ObservedObject var presenter: BuildReviewPresenter
  
  var body: some View {
    NavigationView{
      VStack {
        if presenter.currentReviewView == 1 {
          BuildReviewTimeView(presenter: presenter)
        } else if presenter.currentReviewView == 2 {
          BuildReviewLightView(presenter: presenter)
        } else if presenter.currentReviewView == 3 {
          BuildReviewCrowdView(presenter: presenter)
        } else if presenter.currentReviewView == 4 {
          BuildReviewChatView(presenter: presenter)
        }
        Text("This is BuildReviewView \(presenter.currentReviewView)")
      }
    }
  }
}

struct BuildReviewView_Previews : PreviewProvider {
  static var previews: some View {
    let model = ReviewModel.sampleModel
    let service = BuildReviewService()
    let interactor = BuildReviewInteractor(model: model, service: service)
    let presenter = BuildReviewPresenter(interactor: interactor)
    return BuildReviewView(presenter: presenter)
  }
}



