//
//  LoginService.swift
//  Kairos
//
//  Created by Alex McCaffrey on 10/10/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

enum UserLoginResponse {
  case success(UserLoginData)
  case failure(UserLoginError)
}

enum UserLoginError: Error {
  case genericError
}

class UserLoginService {
  
  func login(data: Data, completion: @escaping (UserLoginResponse) -> Void) {
    
    let url = URL(string: "https://alexmccaffrey.com/api/login")
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.httpBody = data
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    print(String(data: request.httpBody!, encoding: .utf8))
    
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
          print(user)
          completion(UserLoginResponse.success(user))
        } catch {
          let error = self.errorHandler()
          completion(UserLoginResponse.failure(error))
        }
      }
    }
    task.resume()
  }
  
  func errorHandler() -> UserLoginError {
    let error = UserLoginError.genericError
    return error
  }
  
}
