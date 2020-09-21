//
//  DateCriteraView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 8/25/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct DateCriteraView: View {
  
  @ObservedObject var presenter: DateCriteriaPresenter
  
  var body: some View {
    presenter.makeSearchButton()
    presenter.makeSpotSearchView()
  }
}

struct DateCriteraView_Previews: PreviewProvider {
  static var previews: some View {
    let model = SpotModel.sampleModel
    let searchService = SpotFinderSearch()
    let interactor = DateCriteriaInteractor(model: model, searchService: searchService)
    let presenter = DateCriteriaPresenter(interactor: interactor)
    DateCriteraView(presenter: presenter)
  }
}
