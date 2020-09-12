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
  
  init (interactor: SpotSearchInteractor) {
    self.interactor = interactor
  }
  
  @Published var queryData = Places().places
  
}
