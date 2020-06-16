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
  
  var body: some View {
    NavigationView {
      VStack {
        presenter.makeReviewBuilderButton()
          .buttonStyle(PlainButtonStyle())
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    let model = ReviewModel.sampleModel
    let interactor = HomeInteractor(model: model)
    let presenter = HomePresenter(interactor: interactor)
    return HomeView(presenter: presenter)
  }
}

