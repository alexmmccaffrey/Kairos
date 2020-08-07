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
  @State private var searchText = ""
  
  var body: some View {
    VStack {
      SearchBar(text: $searchText)
      presenter.makeButtonForGetSearch(searchText)
      Text("First SpotID = \(presenter.queryData[0].spotID)")
    }
  }
}

struct SpotSearchView_Previews: PreviewProvider {
  static var previews: some View {
      let model = PlacesModel.sampleModel
      let service = SpotNameSearch()
      let interactor = SpotSearchInteractor(model: model, service: service)
      let presenter = SpotSearchPresenter(interactor: interactor)
      return SpotSearchView(presenter: presenter)
    }
}

