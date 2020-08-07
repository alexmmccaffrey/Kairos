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

  func makeButtonForGetSearch(_ query: String) -> some View {
    Button(action: {
      self.interactor.getSearchDetails(query) { (output) in
        DispatchQueue.main.async {
          self.queryData[0].spotID = output[0].spotID
        }
      }
    }, label: {
      Text("Click here to return search")
    })
  }
}
