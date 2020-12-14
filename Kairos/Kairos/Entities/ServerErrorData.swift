//
//  ServerErrorData.swift
//  Kairos
//
//  Created by Alex McCaffrey on 10/9/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

struct ServerError: Codable {
  
  var error: String
  
  init() {
    error = "no errors found"
  }
  
}
