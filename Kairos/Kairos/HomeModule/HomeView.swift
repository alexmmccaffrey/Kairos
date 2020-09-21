//
//  HomeView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/7/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject var presenter: HomePresenter
  
  @State private var searchQuery = ""
  @State private var searchCity = ""
  @State private var searchState = ""

  var body: some View {
    NavigationView {
      VStack {
        Text("Query")
        SearchBar(text: $searchQuery)
        Text("City")
        SearchBar(text: $searchCity)
        Text("State")
        SearchBar(text: $searchState)
        presenter.makeSearch(searchQuery, searchCity, searchState)
        presenter.linkSpotSearchView()
        presenter.makeDateCriteriaView()
        presenter.linkDateCriteriaView()
      }
        .onAppear {
          self.presenter.views = .constant(0)
          self.presenter.overlay = false
          self.presenter.errorMessage = false
        }
        .overlay(ActivityIndicator(isAnimating: .constant(presenter.overlay), style: .large))
    }
  }
  
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    let reviewModel = ReviewModel.sampleModel
    let spotModel = SpotModel.sampleModel
    let searchService = SpotNameSearch()
    let interactor = HomeInteractor(reviewModel: reviewModel, spotModel: spotModel, searchService: searchService)
    let presenter = HomePresenter(interactor: interactor)
    return HomeView(presenter: presenter)
  }
}

