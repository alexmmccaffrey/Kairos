//
//  HomePresenter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/9/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Combine
import Sliders
import SwiftUI

class HomePresenter: ObservableObject {
  
  @ObservedObject var interactor: HomeInteractor
  let router = HomeRouter()
  
  @Published var overlay: Bool = false
  @Published var errorMessage: Bool = false
  
  @Published var dropdownIsShowing: Bool = false
  @Published var timeDropdownIsShowing: Bool = false
  
  @Published var isFilterSearch: Bool = true
  
  @Published var query: String = ""
  
  /// Dropdown Options
  @Published var timeDropdownOptions: [DropdownOption] = [DropdownOption(1, "Morning"), DropdownOption(2, "Afternoon"), DropdownOption(3, "Evening"), DropdownOption(4, "Late Night")]
  @Published var currentTimeDropdownOption: DropdownOption = DropdownOption(3, "Evening")
  
  /// Slider Values
  @Published var lightingSlider: Float = 0.38
  @Published var crowdSlider: Float = 0.38
  @Published var chatSlider: Float = 0.38
  
  @Published var viewNavigation: Int? = nil
  
  @Published var isLocationModal: Bool = false
  
  var anyCancellable: AnyCancellable? = nil
  
  
  init(interactor: HomeInteractor) {
    self.interactor = interactor
    anyCancellable = self.interactor.objectWillChange.sink { [weak self] (_) in
      self?.objectWillChange.send()
    }
  }
  
  
  /// TESTS
  
  func createLocationText() -> some View {
    VStack {
      Text("\(interactor.city)")
      Text("\(interactor.state)")
    }
  }
  
  func updateLocation() -> some View {
    Button(action: {
      self.interactor.city = "wowitsnew"
      self.interactor.state = "wowitsnew2"
    }, label: {
      Text("Hit for update")
    })
  }
  
  /// END TESTS
  
  /// Router Navigation
  
  func logoutButton() -> some View {
    Button(action: {
      UserDefaults.standard.set(false, forKey: "IsLoggedIn")
    }, label: {
      Text("Logout Button")
    })
  }
  
  func linkSpotSearchView(selection: Binding<Int?>) -> some View {
    NavigationLink(
      destination: router.makeSpotSearchModule(
        spotModel: interactor.spotModel,
        timePreference: currentTimeDropdownOption
        ),
      tag: 1,
      selection: selection)
    {
      EmptyView()
    }
  }
  
  /* Can be removed later on */
  func linkDateCriteriaView(selection: Binding<Int?>) -> some View {
    NavigationLink(
      destination: router.makeDateCriteriaView(
        model: interactor.spotModel),
      tag: 2,
      selection: selection)
    {
      EmptyView()
    }
  }
  
//  func makeSearch(_ query: String) -> some View {
//    Button(action: {
//      self.makeSearchAction(query)
//    }, label: {
//      Text("Click here to return search")
//    })
//  }
  
  func makeSpotFinderSearch() -> some View {
    Button(action: {
      self.makeSpotFinderSearchAction()
    }, label: {
      Text("Click here to return SpotFinderSearch")
    })
  }
  
  func makeDateCriteriaView() -> some View {
    Button(action: {
      self.viewNavigation = 2
    }, label: {
      Text("Click here to open DateCriteria")
    })
  }
  
  /// End Router Navigation
  
  
  func makeSearchAction() {
    self.overlay = true
    self.interactor.getSearchDetails(self.query) { (result) in
      if let error = result {
        DispatchQueue.main.async {
          print(error)
          self.overlay = false
        }
      } else if result == nil {
        DispatchQueue.main.async {
          self.viewNavigation = 1
        }
      }
    }
  }
  
  func makeSpotFinderSearchAction() {
    let time = self.currentTimeDropdownOption.timeValue
    let light = self.sliderValue(slider: self.lightingSlider)
    let crowd = self.sliderValue(slider: self.crowdSlider)
    let chat = self.sliderValue(slider: self.chatSlider)
    self.interactor.getSpotFinderSearchDetails(time: time, light: light, crowd: crowd, chat: chat) { (result) in
      if let error = result {
        DispatchQueue.main.async {
          print(error)
          self.overlay = false
        }
      } else if result == nil {
        self.interactor.manageSpotImages { () in
          DispatchQueue.main.async {
            self.viewNavigation = 1
          }
        }
      }
    }
    
    
  }
  
  /// Start Views
  
  func makeLocationButton() -> some View {
    Button(action: {
      withAnimation(.linear(duration: 0.14)) {
        self.isLocationModal.toggle()
      }
    }, label: {
      HStack(spacing: 0) {
        Image("locationPinIconWhite")
          .padding(.trailing, 4)
        Text("Change Location")
          .font(.custom("Metropolis Regular", size: 14.0))
          .foregroundColor(.white)
      }
      .padding(.trailing, 10)
    })
  }
  
  
  func makeSlider(binding: Binding<Float>) -> some View {
    ValueSlider(value: binding)
      .valueSliderStyle(
        HorizontalValueSliderStyle(
          track: HorizontalValueTrack(
            view: Capsule()
              .foregroundColor(Color.white)
              .opacity(0.90)
          )
          .background(
            Capsule()
              .foregroundColor(Color("sliderBackground"))
              .opacity(0.15))
          .frame(height: 10),
          thumb: Circle()
            .strokeBorder(Color("sliderColor"), lineWidth: 0.3)
            .background(
              Circle()
                .foregroundColor(Color.white)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            ),
          thumbSize: CGSize(width: 22.0, height: 22.0),
          thumbInteractiveSize: CGSize(width: 22.0, height: 22.0)
        )
      )
  }
  
  func makeFilterApplyButton(width: CGFloat) -> some View {
    ZStack {
      Button(action: {
        self.isFilterSearch.toggle()
      }, label: {
        HStack{
          Spacer()
          Text(self.isFilterSearch ? "Remove Filters" : "Apply Filters")
            .font(.custom("Metropolis Semi Bold", size: 15.0))
          Spacer()
        }
        .padding(.vertical, 24)
      })
      .frame(width: width, height: 37, alignment: .center)
      .foregroundColor(self.isFilterSearch ? Color.white : Color("appBackground"))
      .background(self.isFilterSearch ? Color("appBackground") : Color.white)
      .cornerRadius(40)
    }
  }
  
  func makeModalUseLocationButton(width: CGFloat) -> some View {
    ZStack {
      Button(action: {
        self.interactor.checkLocation()
      }, label: {
        HStack{
          Spacer()
          Text("Use Current Location")
            .font(.custom("Metropolis Semi Bold", size: 15.0))
          Spacer()
        }
        .padding(.vertical, 24)
      })
      .frame(width: width, height: 30, alignment: .center)
      .foregroundColor(Color("appBackground"))
      .background(Color.white)
      .cornerRadius(40)
      RoundedRectangle(cornerRadius: 40.0)
        .stroke(Color("appBackground"), lineWidth: 1.0)
      .frame(width: width, height: 30, alignment: .center)
    }
  }
  
  func makeModalApplyButton(width: CGFloat) -> some View {
    ZStack {
      Button(action: {
        self.isLocationModal.toggle()
      }, label: {
        HStack{
          Spacer()
          Text("Apply")
            .font(.custom("Metropolis Semi Bold", size: 15.0))
          Spacer()
        }
        .padding(.vertical, 24)
      })
      .frame(width: width, height: 30, alignment: .center)
      .foregroundColor(Color.white)
      .background(Color("appBackground"))
      .cornerRadius(40.0)
    }
  }
  
  func makeSeparatorLineView() -> some View {
    Rectangle()
      .fill(Color.white)
      .frame(height: 1)
  }
  
  func makeGraySeparatorLineView() -> some View {
    Rectangle()
      .fill(Color("bubbleTextFieldOutline"))
      .frame(height: 1)
  }
  
  /// End Views
  
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
  
  /// Validation
  
  
}
