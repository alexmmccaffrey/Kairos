//
//  SpotNameSearch.swift
//  Kairos
//
//  Created by Alex McCaffrey on 7/13/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

enum SpotNameResponse: Error {
  case success([Spot])
  case failure(Error)
}

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
          let spots: [Spot] = try decoder.decode([Spot].self, from: data)
          completion(SpotNameResponse.success(spots))
        } catch {
          completion(SpotNameResponse.failure(error))
        }
      }
    }
    task.resume()
  }
  
}

//let task = session.dataTask(with: request) {
//  (data, response, error) in
//  if let data = data {
//    do {
//      let decoder = JSONDecoder()
//      let spots: [Spot] = try decoder.decode([Spot].self, from: data)
//      completion(SpotNameResponse.success(spots))
//    } catch {
//      completion(SpotNameResponse.failure(error))
//    }
//  }
//}




