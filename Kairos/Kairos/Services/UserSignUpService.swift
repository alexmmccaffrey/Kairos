//
//  LoginService.swift
//  Kairos
//
//  Created by Alex McCaffrey on 10/10/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

enum SignUpResponse {
  case success(UserLoginData)
  case failure(SignUpError)
}

enum SignUpError: Error {
  case genericError
}

class SignUpService {
  
  func signUp(data: Data, completion: @escaping (SignUpResponse) -> Void) {
    
    let url = URL(string: "https://alexmccaffrey.com/api/create_user")
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
          let user: UserLoginData = try decoder.decode(UserLoginData.self, from: data)
          completion(SignUpResponse.success(user))
        } catch {
          let error = self.errorHandler()
          completion(SignUpResponse.failure(error))
        }
      }
    }
    task.resume()
  }
  
  func errorHandler() -> SignUpError {
    let error = SignUpError.genericError
    return error
  }
  
}
