//
//  UserLocationService.swift
//  Kairos
//
//  Created by Alex McCaffrey on 11/28/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

enum UserLocationResponse {
  case success(LocationData)
  case failure(UserLocationError)
}

enum UserLocationError: Error {
  case genericError
}

class UserLocationService {
  
  func getUserLocation(data: Data, completion: @escaping (UserLocationResponse) -> Void) {
    
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
          print(user)
//          completion(UserLocationResponse.success(user))
        } catch (let error) {
          print(error)
          let newerror = self.errorHandler()
          completion(UserLocationResponse.failure(newerror))
        }
      }
    }
    task.resume()
  }
  
  func errorHandler() -> UserLocationError {
    let error = UserLocationError.genericError
    return error
  }
  
}
