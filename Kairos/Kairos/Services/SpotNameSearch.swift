//
//  SpotNameSearch.swift
//  Kairos
//
//  Created by Alex McCaffrey on 7/13/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import Combine

class SpotNameSearch {
  
  func searchPlaces(_ query: String,_ city: String,_ state: String, completionBlock: @escaping ([Place]) -> Void) {
    
    let gPlacesURL = URL(string: "https://alexmccaffrey.com/api/spotsearch/\(query)/\(city)/\(state)")
    var request = URLRequest(url: gPlacesURL!)
    request.httpMethod = "GET"
    
    let session = URLSession(configuration: .default)
    
    let task = session.dataTask(with: request) {
      (data, response, error) in
      if let data = data {
        do {
          let decoder = JSONDecoder()
          let placesData: [Place] = try decoder.decode([Place].self, from: data)
          completionBlock(placesData)
        } catch let error {
          print(error)
        }
      }
    }
    task.resume()
  }
}


