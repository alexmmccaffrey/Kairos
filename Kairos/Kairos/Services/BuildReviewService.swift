//
//  BuildReviewService.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/14/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI


class BuildReviewService {
      
  func postNewReview(_ json: Data) {
    let jsonData = json
    let apiURL = URL(string: "https://alexmccaffrey.com/api/review/")!
    var request = URLRequest(url: apiURL)
    
    request.httpMethod = "POST"
    request.httpBody = jsonData
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: request) {
      (data, response, error) in
      if let data = data {
        if let response = String(bytes: data, encoding: String.Encoding.utf8) {
          print(response)
        }
      }
    }
    task.resume()
  }
}

