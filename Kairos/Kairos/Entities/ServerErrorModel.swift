//
//  ServerErrorModel.swift
//  Kairos
//
//  Created by Alex McCaffrey on 10/9/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class ServerErrorModel {
  
  @Published var serverError = ServerError()

}

//#if DEBUG
extension ServerErrorModel {
  static var sampleModel: ServerErrorModel {
    let model = ServerErrorModel()
    return model
  }
}
//#endif
