//
//  BuildReviewPresenter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/9/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI
import Sliders

class BuildReviewPresenter: ObservableObject {
  let interactor: BuildReviewInteractor
  let router = BuildReviewRouter()
  

  
  init(interactor: BuildReviewInteractor, timePreference: DropdownOption = DropdownOption(3, "Evening")) {
    self.interactor = interactor
    self.currentTimeDropdownOption = timePreference
  }
  
  @Published var timeDropdownOptions: [DropdownOption] = [DropdownOption(1, "Morning"), DropdownOption(2, "Afternoon"), DropdownOption(3, "Evening"), DropdownOption(4, "Late Night")]
  @Published var currentTimeDropdownOption: DropdownOption
  @Published var isDropdown: Bool = false
  @Published var lightSlider: Float = 0.36
  @Published var crowdSlider: Float = 0.36
  @Published var chatSlider: Float = 0.36
  

  func submitReviewAction() {
    let light = sliderValue(slider: lightSlider)
    let crowd = sliderValue(slider: crowdSlider)
    let chat = sliderValue(slider: chatSlider)
    let time = currentTimeDropdownOption.timeValue
    interactor.setNewReview(time: time, light: light, crowd: crowd, chat: chat) {
      self.interactor.submitReview(attempt: 1) { (result) in
        print("Success")
        // Show success message and re-open Spot Details view
      } failure: { (error) in
        print(error)
        print("Fail")
        // Show error message and re-open Spot Details view
      }
    }

  }

  func makeSlider(binding: Binding<Float>) -> some View {
    ValueSlider(value: binding)
      .valueSliderStyle(
        HorizontalValueSliderStyle(
          track: HorizontalValueTrack(
            view: Capsule()
              .foregroundColor(Color("sliderColor"))
          )
          .background(Capsule().foregroundColor(Color("sliderBackground")))
          .frame(height: 10),
          thumb: Circle()
            .strokeBorder(Color("sliderColor"), lineWidth: 0.3)
            .background(
              Circle()
                .foregroundColor(Color.white)
                .shadow(radius: 10)
            ),
          thumbSize: CGSize(width: 22.0, height: 22.0),
          thumbInteractiveSize: CGSize(width: 22.0, height: 22.0)
        )
      )
  }
  
  func makeSpotInfoImage(width: CGFloat) -> some View {
//    Image("itemNotFound")
//      .resizable()
//      .cornerRadius(15.0)
    
    Image(uiImage: interactor.getSpotImage() ?? UIImage(imageLiteralResourceName: "itemNotFound"))
      .resizable()
      .scaledToFill()
      .aspectRatio(1.0, contentMode: .fill)
      .frame(width: width, height: 180)
      .clipShape(RoundedRectangle(cornerRadius: 15.0))
  }
  
  func makeSpotInfoSectionName() -> some View {
    Text(interactor.getSpotName())
  }
  
  func getSpotImage() -> some View {
    Text(interactor.getSpotName())
  }
  
  func makeSubmitButton(width: CGFloat) -> some View {
    ZStack {
      Button(action: {
        self.submitReviewAction()
      }, label: {
        HStack{
          Spacer()
          Text("Submit")
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
  
  func makeSeparatorLineView() -> some View {
    Rectangle()
      .fill(Color("bubbleTextFieldOutline"))
      .frame(height: 0.5)
  }
  
  /// Helper Methods
  func sliderValue(slider: Float) -> Int {
    var value = -1
    if slider < 0.25 {
      value = 1
    } else if slider >= 0.25 && slider < 0.50 {
      value = 2
    } else if slider >= 0.50 && slider < 0.75 {
      value = 3
    } else if slider >= 0.75 && slider <= 1.00 {
      value = 4
    }
    return value
  }
  
  /// End Helper Methods
  
}
