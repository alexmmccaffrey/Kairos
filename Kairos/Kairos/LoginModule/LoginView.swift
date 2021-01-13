//
//  LoginView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 10/17/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct LoginView: View {

  @Environment(\.presentationMode) var mode: Binding<PresentationMode>

  @ObservedObject var presenter: LoginPresenter
  
  @State private var screenWidth: CGFloat = UIScreen.main.bounds.width

  var body: some View {
    NavigationView {
      GeometryReader { GeometryProxy in
        ZStack(alignment: .top) {
          if presenter.isLoading {
            LoadingAnimation(isAnimated: $presenter.isLoadingAnimation, overlayHeight: 170, overlayWidth: 170, animationHeight: 100, animationWidth: 100)
              .zIndex(100)
              .offset(y: 105)
          }
          ZStack {
            Image("loginHeroViewImage")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .edgesIgnoringSafeArea(.all)
            ZStack {
              Image("logo")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color("appBackground"))
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .zIndex(100.0)
              RoundedRectangle(cornerRadius: 15.0)
                .fill(Color.white)
                .frame(width: 110, height: 110)
            }
            .offset(y: -150)
          }
          HStack(spacing: 0) {
            Spacer()
              ZStack(alignment: .top) {
                if presenter.isSignUp == true {
                  presenter.makeSignUpFieldSection()
                    .frame(height: 410)
                } else {
                  presenter.makeLoginFieldSection()
                    .frame(height: 285)
                }
                VStack {
                  ZStack {
                    presenter.makeLoginTabButton()
                      .offset(x: -GeometryProxy.size.width/5)
                    presenter.makeSignUpTabButton()
                      .offset(x: GeometryProxy.size.width/5)
                  }
                  ZStack {
                    underlineView
                      .frame(width: abs(GeometryProxy.size.width-70))
                    if presenter.isSignUp == true {
                      signUpSelection
                        .frame(width: 30)
                        .offset(x: GeometryProxy.size.width/5)
                    } else {
                      signUpSelection
                        .frame(width: 30)
                        .offset(x: -GeometryProxy.size.width/5)
                    }
                  }
                }
                .padding(.top, 25)
                fieldsSection
              }
            Spacer()
          }
          .frame(width: abs(GeometryProxy.size.width-6))
          .padding(.top, 75)
          /// Navigation
          presenter.linkHomeView(selection: $presenter.viewNavigation)
        }
      }
    }
    .navigationBarBackButtonHidden(true)
  }
}

extension LoginView {
  private var loginFieldView: some View {
    TextField("", text: $presenter.username)
  }

  private var emailFieldView: some View {
    TextField("", text: $presenter.email)
  }

  private var passwordFieldView: some View {
    TextField("", text: $presenter.password)
  }

  private var confirmPasswordFieldView: some View {
    TextField("", text: $presenter.confirmPassword)
  }

  private var underlineView: some View {
    Rectangle().frame(height: 1)
      .foregroundColor(Color("bubbleTextFieldOutline"))
  }

  private var signUpSelection: some View {
    RoundedRectangle(cornerRadius: 100, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
      .fill(Color("loginSelection"))
      .frame(height: 3)
  }
  
  private var skipLoginButton: some View {
    Button(action: {
      if self.presenter.isFromHome {
        self.mode.wrappedValue.dismiss()
      } else {
        self.presenter.viewNavigation = 1
      }
    }, label: {
      ZStack {
        RoundedRectangle(cornerRadius: 5.0)
          .fill(Color("viewBackground"))
          .frame(width: 260, height: 30)
        HStack{
          Spacer()
          Text("Continue without login")
            .foregroundColor(Color("loginSelection"))
            .background(Color("viewBackground"))
            .font(.custom("Metropolis Semi Bold", size: 18))
          Spacer()
        }
        .padding(.vertical, 24)
      }
    })
  }
  
  var loginSubmitButton: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 45, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
        .fill(Color.white)
        .frame(width: 270, height: 90, alignment: .center)
        .shadow(radius: 4)
      Button(action: {
        self.makeLoginRequestAction(username: self.presenter.username, password: self.presenter.password)
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

  var signUpSubmitButton: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 45, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
        .fill(Color.white)
        .frame(width: 270, height: 90, alignment: .center)
        .shadow(radius: 4)
      Button(action: {
        self.makeSignUpRequestAction(email: self.presenter.email, username: self.presenter.username, password: self.presenter.password)
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
  
  func makeLoginRequestAction(username: String, password: String) {
    if presenter.checkFieldIsEmptyLogin() {
      DispatchQueue.main.async {
        self.presenter.isLoading = true
        self.presenter.isBackgroundBlur = true
        self.presenter.isBackgroundDisabled = true
      }
      self.presenter.makeLoginRequestAction(username: username, password: password) { (result) in
        if presenter.isFromHome {
          DispatchQueue.main.async {
            self.presenter.isLoading = false
            self.presenter.isBackgroundBlur = false
            self.presenter.isBackgroundDisabled = false
            self.mode.wrappedValue.dismiss()
          }
        } else {
          DispatchQueue.main.async {
            self.presenter.isLoading = false
            self.presenter.isBackgroundBlur = false
            self.presenter.isBackgroundDisabled = false
            self.presenter.viewNavigation = 1
          }
        }
      } failure: { (error) in
        DispatchQueue.main.async {
          self.presenter.isLoading = false
          self.presenter.isBackgroundBlur = false
          self.presenter.isBackgroundDisabled = false
          self.presenter.isLoginError = true
        }
        print(error ?? "error logging in")
        /// SHOW ERROR MODAL FOR LOGIN ACTION
      }
    }
  }
  
  func makeSignUpRequestAction(email: String, username: String, password: String) {
    let checkFieldsEmpty = presenter.checkFieldIsEmptySignUp()
    let checkPasswordsMatch = presenter.checkFieldsMatching()
    if checkFieldsEmpty && checkPasswordsMatch  {
      DispatchQueue.main.async {
        self.presenter.isLoading = true
        self.presenter.isBackgroundBlur = true
        self.presenter.isBackgroundDisabled = true
      }
      self.presenter.makeSignUpRequestAction(email: email, username: username, password: password) { (result) in
        if presenter.isFromHome {
          DispatchQueue.main.async {
            self.presenter.isLoading = false
            self.presenter.isBackgroundBlur = false
            self.presenter.isBackgroundDisabled = false
            self.presenter.isLoginError = true
            self.mode.wrappedValue.dismiss()
          }
        } else {
          DispatchQueue.main.async {
            self.presenter.isLoading = false
            self.presenter.isBackgroundBlur = false
            self.presenter.isBackgroundDisabled = false
            self.presenter.isLoginError = true
            self.presenter.viewNavigation = 1
          }
        }
      } failure: { (error) in
        DispatchQueue.main.async {
          self.presenter.isLoading = false
          self.presenter.isBackgroundBlur = false
          self.presenter.isBackgroundDisabled = false
          self.presenter.isSignUpError = true
        }
        print(error ?? "error signing up") 
      }
    }
  }
  
  private var fieldsSection: some View {
    VStack(spacing: 0) {
      if presenter.isLoginError {
        Text("There was an error logging in")
          .font(.custom("Metropolis Semi Bold", size: 20))
          .foregroundColor(Color.red)
      } else if presenter.isSignUpError {
        Text("There was an error logging in")
          .font(.custom("Metropolis Semi Bold", size: 20))
          .foregroundColor(Color.red)
      }
      VStack(spacing: 0) {
        BubbleTextField(text: $presenter.username, disabled: .constant(false), textFieldView: loginFieldView, placeholder: "Username", imageName: "userIcon")
          .frame(width: abs(screenWidth-60), height: 41, alignment: .center)
          .padding(.top, presenter.isLoginError ? 5 : 25)
          .padding(.bottom, self.presenter.isUsernameEmptyError ? 0 : 12)
        if self.presenter.isUsernameEmptyError {
          Text("Username field is empty")
            .font(.custom("Metropolis Semi Bold", size: 12))
            .foregroundColor(Color.red)
        }
      }
      if presenter.isSignUp == true {
        VStack(spacing: 0) {
          BubbleTextField(text: $presenter.email, disabled: .constant(false), textFieldView: emailFieldView, placeholder: "Email", imageName: "emailIcon")
            .frame(width: abs(screenWidth-60), height: 41, alignment: .center)
            .padding(.top, 13)
            .padding(.bottom, self.presenter.isEmailEmptyError ? 0 : 12)
          if self.presenter.isEmailEmptyError {
            Text("Email field is empty")
              .font(.custom("Metropolis Semi Bold", size: 12))
              .foregroundColor(Color.red)
          }
        }
      }
      VStack(spacing: 0) {
        BubbleTextField(text: $presenter.password, disabled: .constant(false), textFieldView: passwordFieldView, placeholder: "Password", imageName: "lockIcon")
          .frame(width: abs(screenWidth-60), height: 41, alignment: .center)
          .padding(.top, 13)
          .padding(.bottom, self.presenter.isPasswordEmptyError ? 0 : 12)
        if self.presenter.isPasswordEmptyError {
          Text("Password field is empty")
            .font(.custom("Metropolis Semi Bold", size: 12))
            .foregroundColor(Color.red)
        }
      }
      if presenter.isSignUp == true {
        VStack(spacing: 0) {
          BubbleTextField(text: $presenter.confirmPassword, disabled: .constant(false), textFieldView: confirmPasswordFieldView, placeholder: "Confirm Password", imageName: "lockIcon")
            .frame(width: abs(screenWidth-60), height: 41, alignment: .center)
            .padding(.top, 13)
            .padding(.bottom, self.presenter.isConfirmPasswordEmptyError ? 0 : 12)
            .padding(.bottom, self.presenter.isPasswordsNotMatchingError ? 0 : 12 )
          if self.presenter.isConfirmPasswordEmptyError {
            Text("Confirm Password field is empty")
              .font(.custom("Metropolis Semi Bold", size: 12))
              .foregroundColor(Color.red)
          }
          if self.presenter.isPasswordsNotMatchingError {
            Text("Passwords do not match")
              .font(.custom("Metropolis Semi Bold", size: 12))
              .foregroundColor(Color.red)
          }
        }
      }
      Group {
        if presenter.isSignUp == true {
          signUpSubmitButton
        } else {
          loginSubmitButton
        }
      }
      .padding(.top, 13)
      .padding(.bottom, 15)
      Spacer(minLength: 10)
      skipLoginButton
        .padding(.bottom, 10)
    }
    .padding(EdgeInsets(top: 70, leading: 0, bottom: 0, trailing: 0))
  }

}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    let loginService = UserLoginService()
    let signUpService = UserSignUpService()
    let userModel = UserLoginModel.sampleModel
    let interactor = LoginInteractor(loginService: loginService, signUpService: signUpService, userModel: userModel)
    let presenter = LoginPresenter(interactor: interactor, isFromHome: false)
    LoginView(presenter: presenter)
  }
}
