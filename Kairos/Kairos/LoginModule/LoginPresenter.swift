//
//  LoginPresenter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 10/17/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import SwiftUI

class LoginPresenter: ObservableObject {
  let interactor: LoginInteractor
  let router = LoginRouter()
  @Published var isFromHome: Bool
  
  @Published var username: String = "amcctesting"
  @Published var email: String = ""
  @Published var password: String = "password"
  @Published var confirmPassword: String = ""
  @Published var isSignUp: Bool = false
  @Published var viewNavigation: Int? = nil
  @Published var isLoadingAnimation: Bool = false
  @Published var isLoading: Bool = false
  @Published var isBackgroundBlur: Bool = false
  @Published var isBackgroundDisabled: Bool = false
  /// Errors and Validation
  @Published var isUsernameEmptyError: Bool = false
  @Published var isEmailEmptyError: Bool = false
  @Published var isPasswordEmptyError: Bool = false
  @Published var isConfirmPasswordEmptyError: Bool = false
  @Published var isPasswordsNotMatchingError: Bool = false
  @Published var isSignUpError: Bool = false
  @Published var isLoginError: Bool = false
  
  init(interactor: LoginInteractor, isFromHome: Bool) {
    self.interactor = interactor
    self.isFromHome = isFromHome
  }
  
  /// Router Navigation
  
  func linkHomeView(selection: Binding<Int?>) -> some View {
    NavigationLink(
      destination: router.makeHomeView(reviewModel: ReviewModel(), userModel: interactor.userModel),
      tag: 1,
      selection: selection)
    {
      EmptyView()
    }
  }
  
  /* ReviewModel() can be removed from Home view once I'm ready for release */
  
  
  /// End Router Navigation       
  
  /// Actions
  
  func makeLoginRequestAction(username: String, password: String, success: @escaping (UserLoginResponse?) -> Void, failure: @escaping (Error?) -> Void) {
    self.interactor.loginRequest(username: username, password: password) { (result) in
      success(result)
    } failure: { (error) in
      failure(error)
    }
  }
  
  func makeSignUpRequestAction(email: String, username: String, password: String, success: @escaping (UserLoginResponse?) -> Void, failure: @escaping (Error?) -> Void) {
    self.interactor.signUpRequest(email: email, username: username, password: password) { (result) in
      DispatchQueue.main.async {
        UserDefaults.standard.set(true, forKey: "IsLoggedIn")
        self.viewNavigation = 1
      }
    } failure: { (error) in
      print(error!)
    }
  }

  /// Views
  
  func makeLoginFieldSection() -> some View  {
    GeometryReader { GeometryProxy in
      RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
        .fill(Color.white)
        .shadow(radius: 4)
    }
  }
  
  func makeSignUpFieldSection() -> some View  {
    GeometryReader { GeometryProxy in
      RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
        .fill(Color.white)
        .shadow(radius: 4)
    }
  }
  
  func makeLoginTabButton() -> some View {
    Button(action: {
      self.isSignUp = false
    }, label: {
      Text("LOGIN")
        .foregroundColor(Color(isSignUp ? "placeholderText" : "loginSelection"))
        .font(.custom(isSignUp ? "Metropolis Regular" : "Metropolis Semi Bold", size: 20))
    })
  }
  
  func makeSignUpTabButton() -> some View {
    Button(action: {
      self.isSignUp = true
    }, label: {
      Text("SIGN UP")
        .foregroundColor(Color(isSignUp ? "loginSelection" : "placeholderText"))
        .font(.custom(isSignUp ? "Metropolis Semi Bold" : "Metropolis Regular", size: 20))
    })
  }
  
  /// Errors and Validation
  
  func checkFieldIsEmptyLogin() -> Bool {
    isUsernameEmptyError = username.isEmpty
    isPasswordEmptyError = password.isEmpty
    if username.isEmpty || password.isEmpty {
      return false
    } else {
      return true
    }
  }
  
  func checkFieldIsEmptySignUp() -> Bool {
    isUsernameEmptyError = username.isEmpty
    isPasswordEmptyError = password.isEmpty
    isEmailEmptyError = email.isEmpty
    isConfirmPasswordEmptyError = confirmPassword.isEmpty
    if username.isEmpty || password.isEmpty || email.isEmpty || confirmPassword.isEmpty {
      return false
    } else {
      return true
    }
  }
  
  func checkFieldsMatching() -> Bool {
    let check = password != confirmPassword
    isPasswordsNotMatchingError = check
    if password == confirmPassword {
      return true
    } else {
      return false
    }
  }
  
  
}
