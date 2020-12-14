//
//  LoginInteractor.swift
//  Kairos
//
//  Created by Alex McCaffrey on 10/17/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class LoginInteractor {
  let loginService: UserLoginService
  let signUpService: UserSignUpService
  let userModel: UserLoginModel
  
  let defaults = UserDefaults.standard
  
  init(loginService: UserLoginService, signUpService: UserSignUpService, userModel: UserLoginModel) {
    self.loginService = loginService
    self.signUpService = signUpService
    self.userModel = userModel
  }
  
  func loginRequest(username: String, password: String, success: @escaping (UserLoginResponse?) -> Void, failure: @escaping (Error?) -> Void) {
    userModel.user.username = username
    userModel.user.password = password
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let loginData = try encoder.encode(userModel.user)
      loginService.login(data: loginData) { (result) in
        switch result {
          case .success(let user):
            self.userModel.user.password = ""
            self.defaults.set(user.accessToken, forKey: "AccessToken")
            self.defaults.set(user.refreshToken, forKey: "RefreshToken")
            self.defaults.set(user.username, forKey: "Username")
            success(nil)
          case .failure(let error):
            failure(error)
        }
      }
    } catch {
      failure(error)
    }
  }
  
  func signUpRequest(email: String, username: String, password: String, success: @escaping (UserLoginResponse?) -> Void, failure: @escaping (Error?) -> Void) {
    userModel.user.email = email
    userModel.user.username = username
    userModel.user.password = password
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let signUpData = try encoder.encode(userModel.user)
      signUpService.userSignUp(data: signUpData) { (result) in
        switch result {
          case .success(_):
            print("Got that login boiiiiii")
            self.loginRequest(username: username, password: password) { (result) in
              success(nil)
            } failure: { (error) in
              failure(error)
            }
            self.userModel.user.password = ""
            success(nil)
          case .failure(let error):
            failure(error)
        }
      }
    } catch {
      failure(error)
    }
  }
  
  
}
