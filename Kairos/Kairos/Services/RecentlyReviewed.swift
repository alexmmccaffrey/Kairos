//
//  RecentlyReviewed.swift
//  Kairos
//
//  Created by Alex McCaffrey on 12/29/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

enum RecentlyReviewedSpotsResponse: Error {
  case success([Spot])
  case failure(Error)
}

class RecentlyReviewedSpots {
  
  func getRecentlyReviewed(city: String,state: String, completion: @escaping (RecentlyReviewedSpotsResponse) -> Void) {
    
    /// Send Boolean that determines whether location should be taken into account
    
    
    let encodedCity = city.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
    let encodedState = state.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
    
    let url = URL(string: "https://alexmccaffrey.com/api/recentlyreviewed/\(encodedCity!)/\(encodedState!)")
    print(String(describing: url))
    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    
    let session = URLSession(configuration: .default)
    
    let task = session.dataTask(with: request) {
      (data, response, error) in
      if let data = data {
        do {
          let decoder = JSONDecoder()
          guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw self.errorHandler()
          }

          
          let spots: [Spot] = try decoder.decode([Spot].self, from: data)
          completion(RecentlyReviewedSpotsResponse.success(spots))
        } catch let error {
          completion(RecentlyReviewedSpotsResponse.failure(error))
        }
      }
    }
    task.resume()
  }
  
  enum RecentlyReviewedSpotsError: Error {
    case genericError
  }
  
  func errorHandler() -> Error {
    let error = RecentlyReviewedSpotsError.genericError
    return error
  }
  
}
