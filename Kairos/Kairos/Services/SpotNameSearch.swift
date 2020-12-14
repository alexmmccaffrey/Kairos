//
//  SpotNameSearch.swift
//  Kairos
//
//  Created by Alex McCaffrey on 7/13/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class SpotNameSearch {
  
  func searchPlaces(_ query: String,_ city: String,_ state: String, completion: @escaping (SpotNameResponse) -> Void) {
    
    let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
    let encodedCity = city.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
    let encodedState = state.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
    
    let url = URL(string: "https://alexmccaffrey.com/api/spotsearch/\(encodedQuery!)/\(encodedCity!)/\(encodedState!)")
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
          completion(SpotNameResponse.success(spots))
        } catch let error {
          completion(SpotNameResponse.failure(error))
        }
      }
    }
    task.resume()
  }
  
  enum SpotNameResponse: Error {
    case success([Spot])
    case failure(Error)
  }
  
  enum SpotNameSearchError: Error {
    case genericError
  }
  
  func errorHandler() -> Error {
    let error = SpotNameSearchError.genericError
    return error
  }
  
}




