//
//  BuildReviewPresenter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/9/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class BuildReviewPresenter: ObservableObject {
  let interactor: BuildReviewInteractor
  let router = BuildReviewRouter()
  
  
  init(interactor: BuildReviewInteractor) {
    self.interactor = interactor
  }
  
  let objectWillChange = PassthroughSubject<BuildReviewPresenter,Never>()
  var currentReviewView: Int = 1 {
    didSet {
      objectWillChange.send(self)
    }
  }
  
  func makeForwardButton() -> some View {
    Button(action: {
      self.currentReviewView += 1
    }, label: {
      Image(systemName: "arrow.right")
    })
  }

  func makeBackButton() -> some View {
    Button(action: {
      self.currentReviewView -= 1
    }, label: {
      Image(systemName: "arrow.left")
    })
  }

  func makeSubmitButton() -> some View {
    Button(action: {
      self.interactor.submitReview()
    }, label: {
      Text("Submit")
    })
  }
  
  func buildTimeReview(_ timeSelection: Int?) {
    interactor.buildTimeReview(timeSelection)
  }
  
  func buildLightReview(_ lightSelection: Int?) {
    interactor.buildLightReview(lightSelection)
  }
  
  func buildCrowdReview(_ crowdSelection: Int?) {
    interactor.buildCrowdReview(crowdSelection)
  }
  
  func buildChatReview(_ chatSelection: Int?) {
    interactor.buildChatReview(chatSelection)
  }

  public enum TimeTapped: Int, CaseIterable  {
    case none = 0
    case morning = 1
    case noon = 2
    case afternoon = 3
    case evening = 4
    case lateNight = 5
  }
  
  public enum LightTapped: Int, CaseIterable  {
    case none = 0
    case shining = 1
    case bright = 2
    case neutral = 3
    case dim = 4
    case moody = 5
  }
  
  public enum CrowdTapped: Int, CaseIterable  {
    case none = 0
    case c1 = 1
    case c2 = 2
    case c3 = 3
    case c4 = 4
    case c5 = 5
  }
  
  public enum ChatTapped: Int, CaseIterable  {
    case none = 0
    case ch1 = 1
    case ch2 = 2
    case ch3 = 3
    case ch4 = 4
    case ch5 = 5
  }
  
}
