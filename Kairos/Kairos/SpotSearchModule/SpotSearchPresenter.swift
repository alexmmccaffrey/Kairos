//
//  SpotSearchPresenter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 7/27/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import SwiftUI

class SpotSearchPresenter: ObservableObject {
  let interactor: SpotSearchInteractor
  let router = SpotSearchRouter()
  
  @Published var spots: [Spot]?
  @Published var viewNavigation: Int? = nil
  
  init (interactor: SpotSearchInteractor, timePreference: DropdownOption = DropdownOption(3, "Evening")) {
    self.interactor = interactor
    self.timePreference = timePreference
  }
  
  let timePreference: DropdownOption
  
  func spotDetailLink(selection: Binding<Int?>) -> some View {
    NavigationLink(
      destination: router.makeSpotDetailView(
        model: interactor.spotModel,
        timePreference: timePreference),
      tag: 1,
      selection: selection
    ) {
      EmptyView()
    }
  }
  
}
