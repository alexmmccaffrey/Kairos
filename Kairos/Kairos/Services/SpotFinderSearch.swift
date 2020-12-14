//
//  SpotFinderSearch.swift
//  Kairos
//
//  Created by Alex McCaffrey on 9/19/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class SpotFinderSearch {
  
  func spotFinder(time: Int, light: Int, crowd: Int, chat: Int,_ city: String,_ state: String, completion: @escaping (SpotFinderResponse) -> Void) {
    
    let encodedCity = city.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
    let encodedState = state.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
    
    let url = URL(string: "https://alexmccaffrey.com/api/spotfinder/time/\(time)/light/\(light)/crowd/\(crowd)/chat/\(chat)/city/\(encodedCity!)/state/\(encodedState!)")
    print(url)
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
          print(spots)
          completion(SpotFinderResponse.success(spots))
        } catch let error {
          completion(SpotFinderResponse.failure(error))
        }
      }
    }
    task.resume()
  }
  
  enum SpotFinderResponse: Error {
    case success([Spot])
    case failure(Error)
  }
  
  enum SpotFinderSearchError: Error {
    case genericError
  }
  
  func errorHandler() -> Error {
    let error = SpotFinderSearchError.genericError
    return error
  }
  
}

