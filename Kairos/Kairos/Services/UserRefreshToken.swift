//
//  UserRefreshToken.swift
//  Kairos
//
//  Created by Alex McCaffrey on 10/10/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

enum RefreshResponse {
  case success(UserLoginData)
  case failure(RefreshResponseError)
}

enum RefreshResponseError: Error {
  case genericError
}

class UserRefreshToken {
  
  func refresh(user: Data, completion: @escaping (RefreshResponse) -> Void) {
    
    let url = URL(string: "https://alexmccaffrey.com/api/refreshToken")
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.httpBody = user
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
          let user: UserLoginData = try decoder.decode(UserLoginData.self, from: data)
          completion(RefreshResponse.success(user))
        } catch {
          let error = self.errorHandler()
          completion(RefreshResponse.failure(error))
        }
      }
    }
    task.resume()
  }
  
  func errorHandler() -> RefreshResponseError {
    let error = RefreshResponseError.genericError
    return error
  }
  
}
