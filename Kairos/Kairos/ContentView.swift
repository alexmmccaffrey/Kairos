//
//  ContentView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 3/25/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  var body: some View {
    HomeView(presenter:
      HomePresenter(interactor:
        HomeInteractor(model:
          ReviewModel())))
//    BuildReviewView(presenter:
//    BuildReviewPresenter(interactor:
//      BuildReviewInteractor(model:
//        ReviewModel())))
//    TestViewMother(presenter: TestPresenter(interactor: BuildReviewInteractor(model: ReviewModel())))
  }
}

//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    let model: ReviewModel.sample
//    return ContentView()
//      .environmentObject(model)
//  }
//}


//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    let model = DataModel.sample
//    return ContentView()
//      .environmentObject(model)
//  }
//}
