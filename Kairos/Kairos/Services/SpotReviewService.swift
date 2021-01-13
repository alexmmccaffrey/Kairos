//
//  SpotReviewService.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class SpotReviewService {
  
  func getSpotDetails(_ id: Int, completion: @escaping (SpotReviewResponse) -> Void) {
    
    let url = URL(string: "https://alexmccaffrey.com/api/review/\(id)")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let session = URLSession(configuration: .default)
    
    let task = session.dataTask(with: request) {
      (data, response, error) in
      if let data = data {
        do {
          guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw self.errorHandler()
          }
          let decoder = JSONDecoder()
          let spotData = try decoder.decode([Spot].self, from: data)
          let spot = spotData[0]
          completion(SpotReviewResponse.success(spot))
        } catch {
          print(error)
        } 
      }
    }
    task.resume()
  }
  
  
  
  enum SpotReviewResponse: Error {
    case success(Spot)
    case failure(Error)
  }
  
  enum SpotReviewError: Error {
    case genericError
  }
  
  func errorHandler() -> Error {
    let error = SpotReviewError.genericError
    return error
  }
  
}

