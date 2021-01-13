//
//  ReviewCheckService.swift
//  Kairos
//
//  Created by Alex McCaffrey on 12/17/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class ReviewCheckService {
  
  func userReviewCheck(data: Data, completion: @escaping (ReviewCheckResponse) -> Void) {
    
    let url = URL(string: "https://alexmccaffrey.com/api/reviewcheck")!
    var request = URLRequest(url: url)
    request.httpBody = data
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let session = URLSession(configuration: .default)
    
    let task = session.dataTask(with: request) {
      (data, response, error) in
      if let data = data {
        do {
          guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw self.errorHandler()
          }
          completion(ReviewCheckResponse.success)
        } catch {
          completion(ReviewCheckResponse.failure(error))
        }
      }
    }
    task.resume()
  }
  
  
  
  enum ReviewCheckResponse: Error {
    case success
    case failure(Error)
  }
  
  enum ReviewCheckError: Error {
    case genericError
  }
  
  func errorHandler() -> Error {
    let error = ReviewCheckError.genericError
    return error
  }
  
}

