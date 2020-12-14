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
  
  @Published var username: String = "amcctesting"
  @Published var email: String = ""
  @Published var password: String = "password"
  @Published var confirmPassword: String = ""
  
  @Published var isSignUp: Bool = false
  
  @Published var viewNavigation: Int? = nil
  
  init(interactor: LoginInteractor) {
    self.interactor = interactor
  }
  
  /// Router Navigation
  
  func linkHomeView(selection: Binding<Int?>) -> some View {
    NavigationLink(
      destination: router.makeHomeView(reviewModel: ReviewModel()),
      tag: 1,
      selection: selection)
    {
      EmptyView()
    }
  }
  
  /* ReviewModel() can be removed from Home view once I'm ready for release */
  
  
  /// End Router Navigation       
  
  /// Login and Sign Up Actions
  
  func makeLoginRequestAction(username: String, password: String) {
    self.interactor.loginRequest(username: username, password: password) { (result) in
      DispatchQueue.main.async {
        UserDefaults.standard.set(true, forKey: "IsLoggedIn")
        self.viewNavigation = 1
      }
    } failure: { (error) in
      print(error!)
    }
  }
  
  func makeSignUpRequestAction(email: String, username: String, password: String) {
    self.interactor.signUpRequest(email: email, username: username, password: password) { (result) in
      DispatchQueue.main.async {
        UserDefaults.standard.set(true, forKey: "IsLoggedIn")
        self.viewNavigation = 1
      }
    } failure: { (error) in
      print(error!)
    }
  }
  
  /// Login and Sign Up Buttons
  
  func makeLoginSubmitButton() -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 45, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
        .fill(Color.white)
        .frame(width: 270, height: 90, alignment: .center)
        .shadow(radius: 4)
      Button(action: {
        self.makeLoginRequestAction(username: self.username, password: self.password)
      }, label: {
        HStack{
          Spacer()
          Text("Login")
            .foregroundColor(Color.white)
            .font(.custom("Metropolis Semi Bold", size: 18))
          Spacer()
        }
        .padding(.vertical, 24)
      })
      .frame(width: 250, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      .foregroundColor(.white)
      .background(Color("appBackground"))
      .cornerRadius(40)
    }
  }

  func makeSignUpSubmitButton() -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 45, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
        .fill(Color.white)
        .frame(width: 270, height: 90, alignment: .center)
        .shadow(radius: 4)
      Button(action: {
        self.makeSignUpRequestAction(email: self.email, username: self.username, password: self.password)
      }, label: {
        HStack{
          Spacer()
          Text("Sign Up")
            .foregroundColor(Color.white)
            .font(.custom("Metropolis Semi Bold", size: 18))
          Spacer()
        }
        .padding(.vertical, 24)
      })
      .padding()
      .frame(width: 250, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      .foregroundColor(.white)
      .background(Color("appBackground"))
      .cornerRadius(40)
    }
  }
  
  /// End Login and Sign Up Buttons
  
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
  
}
