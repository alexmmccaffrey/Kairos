//
//  SpotModel.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Combine

final class SpotModel: ObservableObject {
  
  @Published var SpotDetails = Spot()
  
}

#if DEBUG
extension SpotModel {
  static var sampleModel: SpotModel {
    let model = SpotModel()
    return model
  }
}
#endif
