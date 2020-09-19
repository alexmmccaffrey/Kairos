//
//  SpotModel.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

final class SpotModel: ObservableObject {
  
  @Published var spot: Spot
  
  @Published var spots: [Spot]?
  
  init(spot: Spot) {
    self.spot = spot
  }
  
}

#if DEBUG
extension SpotModel {
  static var sampleModel: SpotModel {
    let model = SpotModel(spot: Spot())
    return model
  }
}
#endif
