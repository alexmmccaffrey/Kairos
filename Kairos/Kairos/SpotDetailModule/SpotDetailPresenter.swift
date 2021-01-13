//
//  SpotReviewPresenter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import SwiftUI

class SpotDetailPresenter: ObservableObject {
  let interactor: SpotDetailInteractor
  let router = SpotDetailRouter()
  
  init (interactor: SpotDetailInteractor, timePreference: DropdownOption = DropdownOption(3, "Evening")) {
    self.interactor = interactor
    self.currentTimeDropdownOption = timePreference
    lightRating = interactor.model.getLightRating(time: currentTimeDropdownOption.timeValue)
    crowdRating = interactor.model.getCrowdRating(crowd: currentTimeDropdownOption.timeValue)
    chatRating = interactor.model.getChatRating(chat: currentTimeDropdownOption.timeValue)
  }
  
  @Published var navigationTag: Int? = 0
  @Published var timeDropdownOptions: [DropdownOption] = [DropdownOption(1, "Morning"), DropdownOption(2, "Afternoon"), DropdownOption(3, "Evening"), DropdownOption(4, "Late Night")]
  @Published var currentTimeDropdownOption: DropdownOption {
    didSet {
      DispatchQueue.main.async {
        self.lightRating = self.interactor.getLightRating(time: self.currentTimeDropdownOption.timeValue)
        self.crowdRating = self.interactor.getCrowdRating(crowd: self.currentTimeDropdownOption.timeValue)
        self.chatRating = self.interactor.getChatRating(chat: self.currentTimeDropdownOption.timeValue)
      }
    }
  }
  @Published var lightRating: String = "1"
  @Published var crowdRating: String = "1"
  @Published var chatRating: String = "1"
  @Published var isDropdown: Bool = false
  @Published var isLoggedInRequiredModal: Bool = false
  @Published var isMadePreviousReviewModal: Bool = false
  @Published var isReviewSuccessModal: Bool = false
  @Published var isReviewErrorModal: Bool = false
  @Published var isBackgroundBlur: Bool = false
  @Published var isBackgroundDisabled: Bool = false
  
  func buildReviewViewLink(selection: Binding<Int?>) -> some View {
    NavigationLink(
      destination: router.makeBuildReviewView(
        reviewModel: interactor.reviewModel,
        spotModel: interactor.model,
        userModel: interactor.userModel,
        timePreference: currentTimeDropdownOption
      ),
      tag: 1,
      selection: selection)
        {
          EmptyView()
        }
  }
  
  /// Tests
  
  
  /// End Tests
  
  /// Actions
  
  func makeLeaveReviewAction() {
    if self.interactor.getLoggedInStatus() == true {
      interactor.getReviewCheck { (result) in
        DispatchQueue.main.async {
          self.navigationTag = 1
        }
      } failure: { (error) in
        DispatchQueue.main.async {
          withAnimation(.linear(duration: 0.14)) {
            self.isMadePreviousReviewModal = true
            self.isBackgroundBlur = true
            self.isBackgroundDisabled = true
          }
        }
      }
    } else {
      DispatchQueue.main.async {
        withAnimation(.linear(duration: 0.14)) {
          self.isLoggedInRequiredModal = true
          self.isBackgroundBlur = true
          self.isBackgroundDisabled = true
        }
      }
    }
  }
  
  func getSpotName() -> String {
    return self.interactor.getSpotName()
  }
  
  func getSpotAddress() -> String {
    return self.interactor.getSpotAddress()
  }
  
  func getSpotImage() -> UIImage? {
    return self.interactor.getSpotImage()
  }
  
  func getIsReviewSuccess() {
    if interactor.getIsReviewSuccess() == true {
      DispatchQueue.main.async {
        withAnimation(.linear(duration: 0.14)) {
          self.isReviewSuccessModal = true
          self.isBackgroundBlur = true
          self.isBackgroundDisabled = true
        }
      }
    } else if interactor.getIsReviewSuccess() == false {
      DispatchQueue.main.async {
        withAnimation(.linear(duration: 0.14)) {
          self.isReviewErrorModal = true
          self.isBackgroundBlur = true
          self.isBackgroundDisabled = true
        }
      }
    }
  }

  /// Views
  
  func makeSeparatorLineView() -> some View {
    Rectangle()
      .fill(Color("bubbleTextFieldOutline"))
      .frame(height: 0.5)
  }
  
  func makeLoggedInRequiredModal(width: CGFloat) -> some View {
    ZStack(alignment: .top) {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color.white)
        .shadow(radius: 12)
      RoundedRectangle(cornerRadius: 15.0)
        .stroke(Color("viewBackground"), lineWidth: 0.5)
      VStack(spacing: 0) {
        HStack(spacing: 0) {
          Spacer()
          Image("xIcon")
            .onTapGesture(count: 1, perform: {
              withAnimation(.linear(duration: 0.14)) {
                self.isLoggedInRequiredModal = false
                self.isBackgroundBlur = false
                self.isBackgroundDisabled = false
              }
            })
        }
        .padding(.top, 16)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        Text("You must be logged in to leave a review. Go back to the homepage to login!")
          .font(.custom("Metropolis Semi Bold", size: 14.0))
          .padding(.vertical, 8)
          .padding(.horizontal, 32)
        Spacer()
        Button(action: {
          withAnimation(.linear(duration: 0.14)) {
            self.isLoggedInRequiredModal = false
            self.isBackgroundBlur = false
            self.isBackgroundDisabled = false
          }
        }, label: {
          HStack{
            Spacer()
            Text("Got it")
              .font(.custom("Metropolis Semi Bold", size: 15.0))
            Spacer()
          }
          .padding(.vertical, 24)
        })
        .frame(width: width, height: 37, alignment: .center)
        .foregroundColor(.white)
        .background(Color("appBackground"))
        .cornerRadius(40)
        .padding(.bottom, 20)
      }
    }
  }
  
  func makeMadePreviousReviewModal(width: CGFloat) -> some View {
    ZStack(alignment: .top) {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color.white)
        .shadow(radius: 12)
      RoundedRectangle(cornerRadius: 15.0)
        .stroke(Color("viewBackground"), lineWidth: 0.5)
      VStack(spacing: 0) {
        HStack(spacing: 0) {
          Spacer()
          Image("xIcon")
            .onTapGesture(count: 1, perform: {
              withAnimation(.linear(duration: 0.14)) {
                self.isMadePreviousReviewModal = false
                self.isBackgroundBlur = false
                self.isBackgroundDisabled = false
              }
            })
        }
        .padding(.top, 16)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        Text("You've already left a review for this Spot")
          .font(.custom("Metropolis Semi Bold", size: 14.0))
          .padding(.vertical, 8)
          .padding(.horizontal, 32)
        Spacer()
        Button(action: {
          withAnimation(.linear(duration: 0.14)) {
            self.isMadePreviousReviewModal = false
            self.isBackgroundBlur = false
            self.isBackgroundDisabled = false
          }
        }, label: {
          HStack{
            Spacer()
            Text("Oh, gotcha")
              .font(.custom("Metropolis Semi Bold", size: 15.0))
            Spacer()
          }
          .padding(.vertical, 24)
        })
        .frame(width: width, height: 37, alignment: .center)
        .foregroundColor(.white)
        .background(Color("appBackground"))
        .cornerRadius(40)
        .padding(.bottom, 20)
      }
    }
  }
  
  func makeLeaveReviewButton(width: CGFloat) -> some View {
    ZStack {
      Button(action: {
        self.makeLeaveReviewAction()
      }, label: {
        HStack{
          Spacer()
          Text("Leave a Review")
            .font(.custom("Metropolis Semi Bold", size: 15.0))
          Spacer()
        }
        .padding(.vertical, 24)
      })
      .frame(width: width, height: 37, alignment: .center)
      .foregroundColor(.white)
      .background(Color("appBackground"))
      .cornerRadius(40)
    }
  }
  
  func makeLightRatingSection(width: CGFloat) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color("appBackground"))
        .opacity(0.10)
      VStack(alignment: .center, spacing: 0) {
        Image("lightIcon")
          .padding(.top, 4)
        Text(lightRating)
          .font(.custom("Metropolis Regular", size: 14.0))
          .foregroundColor(Color("appBackground"))
          .padding(.vertical, 3)
        Text("Lighting")
          .font(.custom("Metropolis Regular", size: 12.0))
          .foregroundColor(Color("appBackground"))
          .padding(.bottom, 8)
      }
    }
    .frame(width: width, height: 70 ,alignment: .top)
  }
  
  
  func makeCrowdRatingSection(width: CGFloat) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color("appBackground"))
        .opacity(0.10)
      VStack(alignment: .center, spacing: 0) {
        Image("crowdIcon")
          .resizable()
          .scaledToFit()
          .frame(width: 26,height: 18)
          .padding(.top, 8)
        Text(crowdRating)
          .font(.custom("Metropolis Regular", size: 14.0))
          .foregroundColor(Color("appBackground"))
          .padding(.vertical, 3)
        Text("Crowd")
          .font(.custom("Metropolis Regular", size: 12.0))
          .foregroundColor(Color("appBackground"))
          .padding(.bottom, 8)
      }
    }
    .frame(width: width, height: 70 ,alignment: .top)
  }
  
  func makeChatRatingSection(width: CGFloat) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color("appBackground"))
        .opacity(0.10)
        .frame(width: width, height: 70 ,alignment: .top)
      VStack(alignment: .center, spacing: 0) {
        Image("chatIcon")
          .padding(.top, 6)
        Text(chatRating)
          .font(.custom("Metropolis Regular", size: 14.0))
          .foregroundColor(Color("appBackground"))
          .padding(.top, 2)
          .padding(.vertical, 3)
        Text("Chat")
          .font(.custom("Metropolis Regular", size: 12.0))
          .foregroundColor(Color("appBackground"))
          .padding(.bottom, 8)
      }
    }
  }
  
  func makeReviewSuccessModal(width: CGFloat, height: CGFloat) -> some View {
    ZStack(alignment: .top) {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color.white)
        .shadow(radius: 12)
      RoundedRectangle(cornerRadius: 15.0)
        .stroke(Color("viewBackground"), lineWidth: 0.5)
      VStack(spacing: 0) {
        HStack(spacing: 0) {
          Spacer()
          Image("xIcon")
            .onTapGesture(count: 1, perform: {
              withAnimation(.linear(duration: 0.14)) {
                self.isReviewSuccessModal = false
                self.isBackgroundBlur = false
                self.isBackgroundDisabled = false
              }
            })
        }
        .padding(.bottom, 20)
        VStack(alignment: .leading, spacing: 0) {
          Text("Your review was successful!")
        }
        Spacer()
      }
      .padding(.top, 16)
      .padding(.horizontal, 20)
      .padding(.bottom, 16)
    }
    .frame(width: width, height: height)
  }
  
  func makeReviewErrorModal(width: CGFloat, height: CGFloat) -> some View {
    ZStack(alignment: .top) {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color.white)
        .shadow(radius: 12)
      RoundedRectangle(cornerRadius: 15.0)
        .stroke(Color("viewBackground"), lineWidth: 0.5)
      VStack(spacing: 0) {
        HStack(spacing: 0) {
          Spacer()
          Image("xIcon")
            .onTapGesture(count: 1, perform: {
              withAnimation(.linear(duration: 0.14)) {
                self.isReviewErrorModal = false
                self.isBackgroundBlur = false
                self.isBackgroundDisabled = false
              }
            })
        }
        .padding(.bottom, 20)
        VStack(alignment: .leading, spacing: 0) {
          Text("There was an issue leaving your review. Please try again later.")
        }
        Spacer()
        self.makeReviewErrorModalButton()
      }
      .padding(.top, 16)
      .padding(.horizontal, 20)
      .padding(.bottom, 16)
    }
    .frame(width: width, height: height)
  }
  
  func makeReviewErrorModalButton() -> some View {
    ZStack {
      Button(action: {
        DispatchQueue.main.async {
          withAnimation(.linear(duration: 0.14)) {
            self.isReviewErrorModal = false
            self.isBackgroundBlur = false
            self.isBackgroundDisabled = false
          }
        }
      }, label: {
        HStack{
          Spacer()
          Text("Ok")
            .font(.custom("Metropolis Semi Bold", size: 15.0))
          Spacer()
        }
        .padding(.vertical, 4)
      })
      .foregroundColor(Color.white)
      .background(Color("appBackground"))
      .cornerRadius(40)
    }
  }
  

}

