//
//  SpotSearchView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 7/27/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct SpotSearchView: View {
  @ObservedObject var presenter: SpotSearchPresenter
  
  var body: some View {
    VStack {
      Text("Spot = \(self.presenter.interactor.spotModel.spots![0].spotID)")
      presenter.makeSpotDetailButton()
    }
  }
}

struct SpotSearchView_Previews: PreviewProvider {
  static var previews: some View {
    let model = SpotModel.sampleModel
    let service = SpotNameSearch()
    let interactor = SpotSearchInteractor(spotModel: model, service: service)
    let presenter = SpotSearchPresenter(interactor: interactor)
    return SpotSearchView(presenter: presenter)
  }
}

