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

  @State private var username: String = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var confirmPassword: String = ""


  var body: some View {
    NavigationView {
      GeometryReader { GeometryProxy in
        ZStack(alignment: .top) {
          VStack (spacing: 0){
            Image("loginViewHeroImage")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .edgesIgnoringSafeArea(.all)
          }
          HStack(spacing: 0) {
            Spacer()
            VStack(spacing: 0) {
              ZStack(alignment: .top) {
                if presenter.isSignUp == true {
                  presenter.makeSignUpFieldSection()
                    .frame(height: 400)
                } else {
                  presenter.makeLoginFieldSection()
                    .frame(height: 275)
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
                VStack {
                  BubbleTextField(text: $presenter.username, textFieldView: loginFieldView, placeholder: "Username", imageName: "userIcon")
                    .frame(width: abs(GeometryProxy.size.width-60), height: 41, alignment: .center)
                    .padding(.top, 15)
                  if presenter.isSignUp == true {
                    BubbleTextField(text: $presenter.email, textFieldView: emailFieldView, placeholder: "Email", imageName: "emailIcon")
                      .frame(width: abs(GeometryProxy.size.width-60), height: 41, alignment: .center)
                      .padding(.top, 15)
                  }
                  BubbleTextField(text: $presenter.password, textFieldView: passwordFieldView, placeholder: "Password", imageName: "lockIcon")
                    .frame(width: abs(GeometryProxy.size.width-60), height: 41, alignment: .center)
                    .padding(.top, 15)
                  if presenter.isSignUp == true {
                    BubbleTextField(text: $presenter.confirmPassword, textFieldView: confirmPasswordFieldView, placeholder: "Confirm Password", imageName: "lockIcon")
                      .frame(width: abs(GeometryProxy.size.width-60), height: 41, alignment: .center)
                      .padding(.top, 15)
                  }
                }
                .padding(.top, 70)
                if presenter.isSignUp == true {
                  presenter.makeSignUpSubmitButton()
                    .padding(.top, 355)
                } else {
                  presenter.makeLoginSubmitButton()
                    .padding(.top, 230)
                }
              }
              
            }
            Spacer()
          }
          .frame(width: abs(GeometryProxy.size.width-6))
          .padding(.top, 180)
          presenter.linkHomeView(selection: $presenter.viewNavigation)
        }
      }.navigationBarHidden(true)
    }
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

}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    let loginService = UserLoginService()
    let signUpService = UserSignUpService()
    let userModel = UserLoginModel.sampleModel
    let interactor = LoginInteractor(loginService: loginService, signUpService: signUpService, userModel: userModel)
    let presenter = LoginPresenter(interactor: interactor)
    LoginView(presenter: presenter)
  }
}
