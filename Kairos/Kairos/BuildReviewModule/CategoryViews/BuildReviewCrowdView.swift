//
//  BuildReviewCrowdView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/13/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct BuildReviewCrowdView: View {
  
  @ObservedObject var presenter: BuildReviewPresenter
  @State var tapped = BuildReviewPresenter.CrowdTapped.none
  
  var body: some View {
    VStack {
      ForEach(1 ..< 6) { buttonValue in
        return Button(action: {
          self.presenter.buildCrowdReview(Int(buttonValue))
          self.tapped = BuildReviewPresenter.CrowdTapped(rawValue: buttonValue)!
        }, label: {
          Text(String(describing: BuildReviewPresenter.CrowdTapped(rawValue: buttonValue)!))
            .foregroundColor(self.tapped == BuildReviewPresenter.CrowdTapped(rawValue: buttonValue)! ? Color.white : Color.blue)
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 10)
                .fill(self.tapped == BuildReviewPresenter.CrowdTapped(rawValue: buttonValue)! ? Color.blue : Color.white)
                .frame(width: 200, height: 100))
        })
          .frame(width: 200, height: 100)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .stroke(lineWidth: 2)
              .foregroundColor(Color.blue))
      }
      presenter.makeForwardButton()
      presenter.makeBackButton()
    }
  }
}

struct BuildReviewCrowdView_Previews: PreviewProvider {
  static var previews: some View {
    let model = ReviewModel.sampleModel
    let service = BuildReviewService()
    let interactor = BuildReviewInteractor(model: model, service: service)
    let presenter = BuildReviewPresenter(interactor: interactor)
    return BuildReviewCrowdView(presenter: presenter)
  }
}
