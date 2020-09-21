//
//  SpotReviewService.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class SpotReviewService {
  
  func getSpotDetails(_ id: Int, completionBlock: @escaping (Spot) -> Void) {
    
    let apiURL = URL(string: "https://alexmccaffrey.com/api/review/\(id)")!
    var request = URLRequest(url: apiURL)
    request.httpMethod = "GET"
    
    let session = URLSession(configuration: .default)
    
    let task = session.dataTask(with: request) {
      (data, response, error) in
      if let data = data {
        do {
          let decoder = JSONDecoder()
          let spotData = try decoder.decode([Spot].self, from: data)
          let spotDetails = spotData[0]
          completionBlock(spotDetails)
        } catch {
          print(error)
        } 
      }
    }
    task.resume()
  }
}
