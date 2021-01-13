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
  var anyCancellable: AnyCancellable? = nil
  
  /// Dropdown Options
  @Published var timeDropdownOptions: [DropdownOption] = [DropdownOption(1, "Morning"), DropdownOption(2, "Afternoon"), DropdownOption(3, "Evening"), DropdownOption(4, "Late Night")]
  @Published var currentTimeDropdownOption: DropdownOption = DropdownOption(3, "Evening")
  /// Local Location
  @Published var query: String = ""
  /// Slider Values
  @Published var lightingSlider: Float = 0.35
  @Published var crowdSlider: Float = 0.40
  @Published var chatSlider: Float = 0.38
  /// Navigation
  @Published var viewNavigation: Int? = nil
  @Published var isFilterSearch: Bool = false
  /// Display Modals and Overlays
  @Published var dropdownIsShowing: Bool = false
  @Published var timeDropdownIsShowing: Bool = false
  @Published var isLocationModal: Bool = false
  @Published var isSearchErrorModal: Bool = false
  @Published var isLoadingAnimation: Bool = false
  @Published var isLoading: Bool = false
  @Published var isLogoutModal: Bool = false
  @Published var isBackgroundBlur: Bool = false
  @Published var isBackgroundDisabled: Bool = false
  /// Recently Reviewed
  @Published var isRecentlyReviewedLoading: Bool = false
  @Published var isRecentlyReviewedLoadingAnimation: Bool = false
  @Published var isRecentlyReviewedResults: Bool = false
  @Published var didSearchRecentlyReviewed: Bool = false
  /// Nearby Spots
  @Published var isNearbySpotsLoading: Bool = false
  @Published var isNearbySpotsLoadingAnimation: Bool = false
  @Published var isNearbySpotsResults: Bool = false
  @Published var didSearchNearbySpots: Bool = false
  /// Validation and Error Handling
  @Published var errorMessage: Bool = false
  @Published var textFieldDisabled: Bool = false
  @Published var isLocationCityEmptyError: Bool = false
  @Published var isLocationStateEmptyError: Bool = false
  var isLocationApplied: Bool {
    interactor.city != "" && interactor.state != ""
  }
  @Published var isBroken: Bool = true
  
  
  init(interactor: HomeInteractor) {
    self.interactor = interactor
    anyCancellable = self.interactor.objectWillChange.sink { [weak self] (_) in
      DispatchQueue.main.async {
        self?.objectWillChange.send()
      }
    }
  }
  
  /// Router Navigation
  
  func linkSpotSearchView(selection: Binding<Int?>) -> some View {
    NavigationLink(
      destination: router.makeSpotSearchModule(
        spotModel: interactor.spotModel,
        userModel: interactor.userModel,
        timePreference: currentTimeDropdownOption
      ),
      tag: 1,
      selection: selection)
    {
      EmptyView()
    }
  }
  
  func linkLoginView(selection: Binding<Int?>) -> some View {
    NavigationLink(
      destination: router.makeLoginModule(
        userModel: interactor.userModel
      ),
      tag: 2,
      selection: selection)
    {
      EmptyView()
    }
  }
  
  func spotDetailLink(selection: Binding<Int?>) -> some View {
    NavigationLink(
      destination: router.makeSpotDetailView(
        model: interactor.spotModel,
        userModel: interactor.userModel,
        timePreference: currentTimeDropdownOption
      ),
      tag: 3,
      selection: selection
    ) {
      EmptyView()
    }
  }
  
  /// End Router Navigation
  
  /// Actions
  
  func makeSearchAction() {
    if self.isLocationApplied {
      DispatchQueue.main.async {
        self.isLoading = true
        self.isBackgroundBlur = true
        self.isBackgroundDisabled = true
      }
      self.interactor.getSearchDetails(self.query) { (result) in
        DispatchQueue.main.async {
          self.isLoading = false
          self.isBackgroundBlur = false
          self.isBackgroundDisabled = false
        }
        if result != nil {
          DispatchQueue.main.async {
            withAnimation(.linear(duration: 0.14)) {
              self.isSearchErrorModal = true
              self.isBackgroundBlur = true
              self.isBackgroundDisabled = true
            }
          }
        } else if result == nil {
          self.interactor.manageSpotImages { () in
            DispatchQueue.main.async {
              self.viewNavigation = 1
            }
          }
        }
      }
    } else {
      DispatchQueue.main.async {
        withAnimation(.linear(duration: 0.14)) {
          self.isLocationModal = true
          self.isBackgroundBlur = true
          self.isBackgroundDisabled = true
        }
      }
    }
    
    
  }
  
  func makeSpotFinderSearchAction() {
    if self.isLocationApplied {
      DispatchQueue.main.async {
        self.isLoading = true
        self.isBackgroundBlur = true
        self.isBackgroundDisabled = true
      }
      let time = self.currentTimeDropdownOption.timeValue
      let light = self.sliderValue(slider: self.lightingSlider)
      let crowd = self.sliderValue(slider: self.crowdSlider)
      let chat = self.sliderValue(slider: self.chatSlider)
      self.interactor.getSpotFinderSearchDetails(time: time, light: light, crowd: crowd, chat: chat) { (result) in
        DispatchQueue.main.async {
          self.isLoading = false
          self.isBackgroundBlur = false
          self.isBackgroundDisabled = false
        }
        if let error = result {
          DispatchQueue.main.async {
            withAnimation(.linear(duration: 0.14)) {
              self.isSearchErrorModal = true
              self.isBackgroundBlur = true
              self.isBackgroundDisabled = true
            }
          }
            print(error)
        } else if result == nil {
          if self.interactor.getAreSpotsReturnedInSearch() {
            self.interactor.manageSpotImages { () in
              DispatchQueue.main.async {
                self.viewNavigation = 1
              }
            }
          } else {
            DispatchQueue.main.async {
              withAnimation(.linear(duration: 0.14)) {
                self.isSearchErrorModal = true
                self.isBackgroundBlur = true
                self.isBackgroundDisabled = true
              }
            }
          }
        }
      }
    } else {
      self.isLocationModal = true
      self.isBackgroundBlur = true
      self.isBackgroundDisabled = true
    }
  }
  
  func geLoggedInStatus() -> Bool {
    return interactor.getLoggedInStatus()
  }
  
  func getUserName() -> String {
    return interactor.getUserName()
  }
  
  func applyLocationAction() {
    let locationCheck = checkLocationFieldsEmpty()
    if locationCheck {
      self.interactor.city = self.interactor.viewCity
      self.interactor.state = self.interactor.viewState
      self.isLocationModal = false
      self.isBackgroundBlur = false
      self.isBackgroundDisabled = false
    }
  }
  
  func toggleLocationValidationErrors(errors: Bool) {
    if errors == true {
      self.isLocationCityEmptyError = true
      self.isLocationStateEmptyError = true
    } else {
      self.isLocationCityEmptyError = false
      self.isLocationStateEmptyError = false
    }
  }
  
  func checkLocation() {
    self.interactor.checkLocation()
  }
  
  func getNearbySpotResults(hasMadeSearch: Bool) {
//    if hasMadeSearch != true {
      DispatchQueue.main.async {
        self.isNearbySpotsLoading = true
      }
      self.interactor.getNearbySpots { (result) in
        DispatchQueue.main.async {
          self.isNearbySpotsLoading = false
        }
        self.isNearbySpotsResults = true
        self.didSearchNearbySpots = true
        /// Add code here that will ensure the view will show the results that have been received
      } failure: { (error) in
        DispatchQueue.main.async {
          self.isNearbySpotsLoading = false
          self.isNearbySpotsResults = false
          self.didSearchNearbySpots = true
        }
      }
//    }
  }
  
  func getRecentlyReviewedSpotResults(hasMadeSearch: Bool) {
    if hasMadeSearch != true {
      DispatchQueue.main.async {
        self.isRecentlyReviewedLoading = true
      }
      self.interactor.getRecentlyReviewedSpots { (result) in
        DispatchQueue.main.async {
          self.isRecentlyReviewedLoading = false
        }
        self.isRecentlyReviewedResults = true
        self.didSearchRecentlyReviewed = true
        /// Add code here that will ensure the view will show the results that have been received
      } failure: { (error) in
        DispatchQueue.main.async {
          self.isRecentlyReviewedLoading = false
          self.isRecentlyReviewedResults = false
          self.didSearchRecentlyReviewed = true
        }
      }
    }
  }
  
  /// End Actions
  
  /// Start Views
  
  func makeSpotFinderSearchButton() -> some View {
    ZStack {
      Button(action: {
        self.makeSpotFinderSearchAction()
      }, label: {
        HStack{
          Spacer()
          Text("Make Spot Filter Search")
            .font(.custom("Metropolis Semi Bold", size: 15.0))
          Spacer()
        }
        .padding(.vertical, 4)
      })
      .foregroundColor(Color.white)
      .background(Color("secondaryButton"))
      .cornerRadius(40)
    }
  }
  
  func makeLocationButton() -> some View {
    Button(action: {
      self.interactor.viewCity = self.interactor.city
      self.interactor.viewState = self.interactor.state
      DispatchQueue.main.async {
        if self.isLocationModal {
          DispatchQueue.main.async {
            withAnimation(.linear(duration: 0.14)) {
            self.isLocationModal = false
            self.isBackgroundBlur = false
            self.isBackgroundDisabled = false
            }
          }
        } else {
          DispatchQueue.main.async {
            self.isLogoutModal = false
            self.isSearchErrorModal = false
            withAnimation(.linear(duration: 0.14)) {
              self.isLocationModal = true
              self.isBackgroundBlur = true
              self.isBackgroundDisabled = true
            }
          }
        }
      }
    }, label: {
      HStack(spacing: 0) {
        Image("locationPinIconWhite")
          .padding(.trailing, 4)
        Text(self.isLocationApplied ? "\(interactor.getCity()), \(interactor.getState())" : "Change Location")
          .font(.custom("Metropolis Regular", size: 14.0))
          .foregroundColor(.white)
      }
      .frame(alignment: .trailing)
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
        DispatchQueue.main.async {
          self.isFilterSearch.toggle()
        }
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
        self.applyLocationAction()
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
  
  func makeSearchErrorModal(width: CGFloat, height: CGFloat) -> some View {
    ZStack(alignment: .top) {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color.white)
        .shadow(radius: 12)
      RoundedRectangle(cornerRadius: 15.0)
        .stroke(Color("viewBackground"), lineWidth: 0.5)
      VStack(spacing: 0) {
        HStack(spacing: 0) {
          Image("searchIcon")
            .renderingMode(.template)
            .foregroundColor(Color("appBackground"))
            .padding(.trailing, 8)
          Spacer()
          Image("xIcon")
            .onTapGesture(count: 1, perform: {
              DispatchQueue.main.async {
                withAnimation(.linear(duration: 0.14)) {
                  self.isSearchErrorModal = false
                  self.isBackgroundBlur = false
                  self.isBackgroundDisabled = false
                }
              }
            })
        }
        .padding(.bottom, 20)
        VStack(alignment: .leading, spacing: 0) {
          Text("There was an issue with your search. Please try another search or try again later.")
        }
        Spacer()
        self.makeSearchErrorModalButton()
      }
      .padding(.top, 16)
      .padding(.horizontal, 20)
      .padding(.bottom, 16)
    }
    .frame(width: width, height: height)
  }
  
  func makeSearchErrorModalButton() -> some View {
    ZStack {
      Button(action: {
        DispatchQueue.main.async {
          withAnimation(.linear(duration: 0.14)) {
            self.isSearchErrorModal = false
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
  
  func makeLogoutModal(width: CGFloat, height: CGFloat) -> some View {
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
                self.isLogoutModal = false
                self.isBackgroundBlur = false
                self.isBackgroundDisabled = false
              }
            })
        }
        .padding(.bottom, 20)
        Text("Would you like to logout?")
        Spacer()
        self.makeLogoutModalButton()
      }
      .padding(.top, 16)
      .padding(.horizontal, 20)
      .padding(.bottom, 16)
    }
    .frame(width: width, height: height)
  }
  
  func makeLogoutModalButton() -> some View {
    ZStack {
      Button(action: {
        self.interactor.logout()
        DispatchQueue.main.async {
            withAnimation(.linear(duration: 0.14)) {
            self.viewNavigation = 2
            self.isLogoutModal = false
            self.isBackgroundBlur = false
            self.isBackgroundDisabled = false
          }
        }
      }, label: {
        HStack{
          Spacer()
          Text("Logout")
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
  
  func makeHomeHeroSection() -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color("viewBackground"))
      VStack(alignment: .leading, spacing: 0) {
        Text("Leave a review by logging in and searching for a spot that you've been to... Let us know what it was like!")
          .font(.custom("Metropolis Regular", size: 15.0))
          .foregroundColor(Color("darkFont"))
          .padding(.horizontal, 12)
      }
    }
  }

  func makeRecentlyReviewedHeader() -> some View {
    HStack(spacing: 0) {
      makeGraySeparatorLineView()
      Text("Recently Reviewed")
        .font(.custom("Metropolis Medium", size: 16.0))
        .foregroundColor(Color("darkFont"))
        .frame(width: 180, height: 16)
      makeGraySeparatorLineView()
    }
    .padding(EdgeInsets(top: 0.0, leading: 20.0, bottom: 0.0, trailing: 20.0))
  }
  
  func makeRecentlyReviewedSection(cellWidth: CGFloat) -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(interactor.spotModel.spots ?? []) { spot in
          SpotlightCell(cellWidth: cellWidth, cellHeight: 180.0, spotName: spot.name, spotCategory: spot.category ?? "Spot category not found", spotAddress: spot.address ?? "Spot address not found", image: spot.image)
            .padding(.horizontal, 8)
            .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
              self.interactor.spotModel.spot = spot
              self.viewNavigation = 3
            })
        }
      }
      .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 14.0))
      .frame(height: 240.0)
    }
  }
  
  func makeRecentlyReviewedSectionZeroState() -> some View {
    VStack(alignment: .center, spacing: 0) {
      ZStack {
        Circle()
          .fill(Color("viewBackground"))
          .frame(width: 100, height: 100)
        Image("searchIcon")
          .resizable()
          .renderingMode(.template)
          .foregroundColor(Color.white)
          .frame(width: 40, height: 40)
      }
      Text("There are no recently reviewed Spots.")
        .padding(.top, 12)
        .padding(.bottom, 6)
        .multilineTextAlignment(.center)
        .font(.custom("Metropolis Medium", size: 16.0))
        .foregroundColor(Color("darkFont"))
      Text("Come back later to see which Spots are trending.")
        .padding(.top, 4)
        .padding(.horizontal, 8)
        .multilineTextAlignment(.center)
        .font(.custom("Metropolis Medium", size: 14.0))
        .foregroundColor(Color("viewBackground"))
    }
    .frame(height: 200)
    .padding(EdgeInsets(top: 0.0, leading: 20.0, bottom: 0.0, trailing: 20.0))
  }
  
  func makeNearbySpotsHeader() -> some View {
    HStack(spacing: nil) {
      makeGraySeparatorLineView()
      Text("Nearby")
        .font(.custom("Metropolis Medium", size: 16.0))
        .foregroundColor(Color("darkFont"))
        .frame(width: 90, height: 16)
      makeGraySeparatorLineView()
    }
    .padding(EdgeInsets(top: 0.0, leading: 20.0, bottom: 4.0, trailing: 20.0))
  }
  
  func makeNearbySpotsSection(cellWidth: CGFloat) -> some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: nil) {
        ForEach(interactor.spotModel.spots ?? []) { spot in
          WideSpotCell(cellWidth: cellWidth, spotName: spot.name, spotCategory: spot.category ?? "Spot category not found", spotAddress: spot.address ?? "Spot address not found", image: spot.image)
            .padding(.vertical, 2)
            .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
              self.interactor.spotModel.spot = spot
              self.viewNavigation = 3
            })
        }
      }
      .padding(EdgeInsets(top: 22.0, leading: 24.0, bottom: 28.0, trailing: 24.0))
    }
    .clipShape(RoundedRectangle(cornerRadius: 30.0))
  }
  
  func makeNearbySpotsZeroState() -> some View {
    VStack(alignment: .center, spacing: 0) {
      ZStack {
        Circle()
          .fill(Color("viewBackground"))
          .frame(width: 100, height: 100)
        Image("searchIcon")
          .resizable()
          .renderingMode(.template)
          .foregroundColor(Color.white)
          .frame(width: 40, height: 40)
      }
      Text("There are no reviewed Spots near you.")
        .padding(.top, 12)
        .padding(.bottom, 6)
        .multilineTextAlignment(.center)
        .font(.custom("Metropolis Medium", size: 16.0))
        .foregroundColor(Color("darkFont"))
      Text("Search for a Spot and leave a review!")
        .padding(.top, 4)
        .padding(.horizontal, 8)
        .multilineTextAlignment(.center)
        .font(.custom("Metropolis Medium", size: 14.0))
        .foregroundColor(Color("viewBackground"))
    }
    .frame(height: 200)
    .padding(EdgeInsets(top: 0.0, leading: 20.0, bottom: 0.0, trailing: 20.0))
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
  
  /// Errors and Validation
  
  func checkLocationFieldsEmpty() -> Bool {
    isLocationCityEmptyError = interactor.viewCity.isEmpty
    isLocationStateEmptyError = interactor.viewState.isEmpty
    if interactor.viewCity.isEmpty || interactor.viewState.isEmpty {
      return false
    } else {
      return true
    }
  }
  
  
}
