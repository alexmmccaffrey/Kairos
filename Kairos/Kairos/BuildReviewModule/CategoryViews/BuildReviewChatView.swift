//
//  BuildReviewChatView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/13/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct BuildReviewChatView: View {
  
  @ObservedObject var presenter: BuildReviewPresenter
  @State var tapped = BuildReviewPresenter.ChatTapped.none
  
  var body: some View {
    VStack {
      ForEach(1 ..< 6) { buttonValue in
        return Button(action: {
          self.presenter.buildChatReview(Int(buttonValue))
          self.tapped = BuildReviewPresenter.ChatTapped(rawValue: buttonValue)!
        }, label: {
          Text(String(describing: BuildReviewPresenter.ChatTapped(rawValue: buttonValue)!))
            .foregroundColor(self.tapped == BuildReviewPresenter.ChatTapped(rawValue: buttonValue)! ? Color.white : Color.blue)
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 10)
                .fill(self.tapped == BuildReviewPresenter.ChatTapped(rawValue: buttonValue)! ? Color.blue : Color.white)
                .frame(width: 200, height: 100))
        })
          .frame(width: 200, height: 100)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .stroke(lineWidth: 2)
              .foregroundColor(Color.blue))
      }
      presenter.makeBackButton()
      presenter.makeSubmitButton()
    }
  }
}

struct BuildReviewChatView_Previews: PreviewProvider {
  static var previews: some View {
    let model = ReviewModel.sampleModel
    let service = BuildReviewService()
    let interactor = BuildReviewInteractor(model: model, service: service)
    let presenter = BuildReviewPresenter(interactor: interactor)
    return BuildReviewChatView(presenter: presenter)
  }
}
