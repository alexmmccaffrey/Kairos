//
//  SpotReviewView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct SpotReviewView: View {
  
  @ObservedObject var presenter: SpotDetailPresenter
  
  var body: some View {
    VStack {
      presenter.makeButtonForGetCall()
      Text("SpotID = ")
      Text("Time = ")
      Text("Chat = ")
      Text("Light = ")
      Text("Crowd = ")
    }
  }
}

struct SpotReviewView_Previews: PreviewProvider {
  static var previews: some View {
    let model = SpotModel.sampleModel
    let service = SpotReviewService()
    let interactor = SpotReviewInteractor(model: model, service: service)
    let presenter = SpotReviewPresenter(interactor: interactor)
    return SpotReviewView(presenter: presenter)
  }
}
