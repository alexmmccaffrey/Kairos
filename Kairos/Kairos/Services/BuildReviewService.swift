//
//  BuildReviewService.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/14/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

enum BuildReviewResponse: Error {
  case success
  case failure(BuildReviewError)
}

enum BuildReviewError: Error {
  case authError
  case genericError
}

class BuildReviewService {
      
  func postNewReview(data: Data, accessToken: String, completion: @escaping (BuildReviewResponse) -> Void) {
    
    let url = URL(string: "https://alexmccaffrey.com/api/review/")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = data
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(accessToken, forHTTPHeaderField: "Authorization")
    
    print(String(describing: request))
    
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: request) {
      (data, response, error) in
      if let data = data {
        do {
          guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw self.errorHandler()
          }
          if let response = String(bytes: data, encoding: String.Encoding.utf8) {
            print(response)
          }
          completion(.success)
        } catch {
          let error = self.errorHandler()
          completion(BuildReviewResponse.failure(error))
        }
              }
    }
    task.resume()
  }
  
  func errorHandler() -> BuildReviewError {
    let error = BuildReviewError.genericError
    return error
  }
  
    
}

