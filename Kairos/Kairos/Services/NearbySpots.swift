//
//  NearbySpots.swift
//  Kairos
//
//  Created by Alex McCaffrey on 12/29/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

enum NearbySpotsResponse: Error {
  case success([Spot])
  case failure(Error)
}

enum NearbySpotsError: Error {
  case genericError
}

class NearbySpots {
  
  func getNearbySpots(data: Data, completion: @escaping (NearbySpotsResponse) -> Void) {
    
    let url = URL(string: "https://alexmccaffrey.com/api/nearbyspots")
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.httpBody = data
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
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
          completion(NearbySpotsResponse.success(spots))
        } catch let error {
          completion(NearbySpotsResponse.failure(error))
        }
      }
    }
    task.resume()
  }
  
  func errorHandler() -> Error {
    let error = NearbySpotsError.genericError
    return error
  }
  
}




