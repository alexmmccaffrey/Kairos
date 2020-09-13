//
//  SpotDetailView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct SpotDetailView: View {
  
  @ObservedObject var presenter: SpotDetailPresenter
  
  var body: some View {
    VStack {
      presenter.makeButtonForGetCall()
//      Text("SpotID = \(self.presenter.spotData.spotID)")
//      Text("Time = \(self.presenter.spotData.time)")
//      Text("Chat = \(self.presenter.spotData.chat)")
//      Text("Light = \(self.presenter.spotData.light)")
//      Text("Crowd = \(self.presenter.spotData.crowd)")
    }
  }
}

struct SpotDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let model = SpotModel.sampleModel
    let service = SpotReviewService()
    let interactor = SpotDetailInteractor(model: model, service: service)
    let presenter = SpotDetailPresenter(interactor: interactor)
    return SpotDetailView(presenter: presenter)
  }
}
