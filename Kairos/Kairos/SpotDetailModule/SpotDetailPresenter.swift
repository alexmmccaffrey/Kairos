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
    crowdRating = interactor.model.getCrowdRating(time: currentTimeDropdownOption.timeValue)
    chatRating = interactor.model.getChatRating(time: currentTimeDropdownOption.timeValue)
  }
  
  //// CROWD TESTS
  
  
  
  
  //// END CROWD TESTS
  
  @Published var navigationTag: Int? = 0
  @Published var timeDropdownOptions: [DropdownOption] = [DropdownOption(1, "Morning"), DropdownOption(2, "Afternoon"), DropdownOption(3, "Evening"), DropdownOption(4, "Late Night")]
  @Published var currentTimeDropdownOption: DropdownOption {
    didSet {
      DispatchQueue.main.async {
        self.lightRating = self.interactor.getLightRating(time: self.currentTimeDropdownOption.timeValue)
        self.crowdRating = self.interactor.getCrowdRating(time: self.currentTimeDropdownOption.timeValue)
        self.chatRating = self.interactor.getChatRating(time: self.currentTimeDropdownOption.timeValue)
      }
    }
  }
  
  @Published var lightRating: String = "1"
  @Published var crowdRating: String = "1"
  @Published var chatRating: String = "1"
  
  @Published var isDropdown: Bool = false
  
  func buildReviewViewLink(selection: Binding<Int?>) -> some View {
    NavigationLink(
      destination: router.makeBuildReviewView(
        reviewModel: ReviewModel(),
        spotModel: interactor.model,
        timePreference: currentTimeDropdownOption
      ),
      tag: 1,
      selection: selection)
        {
          EmptyView()
        }
  }
  
  func makeSeparatorLineView() -> some View {
    Rectangle()
      .fill(Color("bubbleTextFieldOutline"))
      .frame(height: 0.5)
  }
  
  func makeButton() -> some View {
    Button(action: {
      print(self.currentTimeDropdownOption)
      print(self.isDropdown)
    }, label: {
        Text("Button this bichhh")
    })
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
  
//  func getCrowdRating() -> View {
//    Text(crowdRating ?? "")
//  }
  
  func makeSubmitButton(width: CGFloat) -> some View {
    ZStack {
      Button(action: {
        self.navigationTag = 1
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
  

}

