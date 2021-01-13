//
//  HomeView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/7/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI
import Sliders

struct HomeView: View {

  @ObservedObject var presenter: HomePresenter
  
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  
  @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
  
  @State var isBroken: Bool = true
  
  init(presenter: HomePresenter) {
    self.presenter = presenter
    UIScrollView.appearance().bounces = false
  }
  
  var body: some View {
    NavigationView {
      GeometryReader { GeometryProxy in
        ZStack(alignment: .top) {
          if self.presenter.isLoading {
            LoadingAnimation(isAnimated: $presenter.isLoadingAnimation, overlayHeight: 130, overlayWidth: 130, animationHeight: 100, animationWidth: 100)
              .zIndex(10.0)
              .offset(y: 100)
          }
          if self.presenter.isSearchErrorModal {
            presenter.makeSearchErrorModal(width: abs(GeometryProxy.size.width-96), height: 165)
              .zIndex(10.0)
              .offset(y: 100)
          }
          if presenter.isLocationModal {
            locationModal
              .zIndex(10.0)
              .offset(y: 100)
          }
          if presenter.isLogoutModal {
            presenter.makeLogoutModal(width: abs(GeometryProxy.size.width-96), height: 135)
              .zIndex(10.0)
              .offset(y: 200)
          }
          VStack(spacing: 0) {
            ZStack(alignment: .top) {
              if presenter.dropdownIsShowing {
                RoundedRectangle(cornerRadius: 15.0)
                  .fill(Color("appBackground"))
                  .shadow(radius: 13)
                  .frame(height: presenter.dropdownIsShowing ? nil : 60)
                  .transition(.move(edge: .top))
              }
              VStack(spacing: 0) {
                if presenter.dropdownIsShowing {
                  VStack {
                    dropdownView
                      .padding(.top, 60)
                      .padding(.horizontal, 18)
                    presenter.makeFilterApplyButton(width: abs(GeometryProxy.size.width-80))
                      .padding(.top, 20)
                      .padding(.bottom, 34)
                  }
                  .transition(.move(edge: .top))
                }
              }
              Rectangle()
                .fill(Color("appBackground"))
                .frame(width: GeometryProxy.size.width+40, height: 85)
                .padding(.top, -25)
                .padding(.horizontal, -20)
              ZStack(alignment: .top) {
                searchBarView
                  .zIndex(2.0)
                  .padding(.bottom, 10)
                RoundedRectangle(cornerRadius: 18.0)
                  .fill(Color.white)
                  .opacity(0.15)
                  .frame(height: presenter.dropdownIsShowing ? nil : 32)
              }
              .padding(.vertical, 18.0)
              .frame(width: abs(GeometryProxy.size.width-32))
            }
            recentlyReviewedSection
            .padding(.top, 20)
              .onTapGesture() {
                self.presenter.interactor.isBroken = false
                self.presenter.isBroken = false
                self.isBroken = false
              }
            nearbySpotsSection
            .ignoresSafeArea(edges: .bottom)
            .onTapGesture() {
//              print(self.presenter.isLocationApplied)
              print(self.presenter.interactor.isBroken)
              print(self.presenter.isBroken)
              print(self.isBroken)
            }
          }
          .frame(width: GeometryProxy.size.width, alignment: .top)
          .navigationBarBackButtonHidden(true)
          .navigationBarTitle("")
          .navigationBarTitleDisplayMode(.inline)
          .blur(radius: presenter.isBackgroundBlur ? 10 : 0)
          .disabled(presenter.isBackgroundDisabled)
        }
        .onAppear() {
          presenter.checkLocation()
          presenter.getNearbySpotResults(hasMadeSearch: presenter.didSearchNearbySpots)
          presenter.getRecentlyReviewedSpotResults(hasMadeSearch: presenter.didSearchRecentlyReviewed)
        }
        presenter.linkSpotSearchView(selection: $presenter.viewNavigation)
        presenter.linkLoginView(selection: $presenter.viewNavigation)
        presenter.spotDetailLink(selection: $presenter.viewNavigation)
      }
      .navigationBarItems(leading: userButton.frame(alignment: .leading),
                          trailing: locationButton.frame(alignment: .trailing))
      .ignoresSafeArea(.keyboard, edges: .bottom)
      .ignoresSafeArea(edges: .bottom)
    }
    .ignoresSafeArea(edges: .bottom)
    .zIndex(2.0)
    .navigationBarHidden(true)
    .background(Color.white)
  }
}

extension HomeView {
  
  private var userButton: some View {
    Button(action: {
      if self.presenter.geLoggedInStatus() {
        if presenter.isLogoutModal {
          DispatchQueue.main.async {
            withAnimation(.linear(duration: 0.14)) {
            presenter.isLogoutModal = false
            presenter.isBackgroundBlur = false
            presenter.isBackgroundDisabled = false
            }
          }
        } else {
          DispatchQueue.main.async {
            presenter.isLocationModal = false
            presenter.isSearchErrorModal = false
            withAnimation(.linear(duration: 0.14)) {
              presenter.isLogoutModal = true
              presenter.isBackgroundBlur = true
              presenter.isBackgroundDisabled = true
            }
          }
        }
      } else {
        self.presenter.viewNavigation = 2
      }
    }, label: {
      HStack(spacing: 0) {
        ZStack() {
          Circle()
            .fill(Color.white)
          Image("logoIcon")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(Color("appBackground"))
            .aspectRatio(contentMode: .fit)
            .zIndex(100.0)
        }
        .frame(width: 25, height: 25)
        .padding(.trailing, 6)
        if self.presenter.geLoggedInStatus() {
          EmptyView()
        } else {
          Text("Login")
            .font(.custom("Metropolis Medium", size: 16.0))
            .foregroundColor(.white)
        }
        Spacer()
      }
      .frame(width: 90, alignment: .leading)
      .padding(.trailing, 10)
    })
  }
  
  private var locationButton: some View {
    presenter.makeLocationButton()
  }
  
  private var searchBarView: some View {
    ZStack(alignment: .trailing) {
      BubbleTextField(text: presenter.textFieldDisabled ? .constant("") : $presenter.query, disabled: $presenter.textFieldDisabled, textFieldView: queryFieldView, placeholder: presenter.textFieldDisabled ? "" : "What are you looking for?", placeholderFontColor: Color.white, ifBorder: false, leadingIconPadding: 14.0, trailingIconPadding: 10.0, cornerRad: 30.0, imageName: "searchIcon")
        .background(
          Color.white
            .opacity(0.15)
        )
        .cornerRadius(30.0)
      HStack {
        if presenter.isFilterSearch {
          presenter.makeSpotFinderSearchButton()
            .frame(height: 32)
            .padding(.leading, 40)
          Spacer()
        }
        ZStack {
          RoundedRectangle(cornerRadius: 30.0)
            .fill(Color.white)
            .opacity(0.15)
          Image("filterIcon")
        }
        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
          withAnimation(.linear(duration: 0.14)) {
            presenter.dropdownIsShowing.toggle()
          }
        })
        .frame(width: 46, height: 32)
      }
    }
  }
  
  private var disabledFieldView: some View {
    TextField("", text: .constant(""))
      .font(.custom("Metropolis Regular", size: 14.0))
  }

  private var cityFieldView: some View {
    TextField("", text: presenter.$interactor.viewCity)
      .font(.custom("Metropolis Regular", size: 14.0))
  }
  
  private var stateFieldView: some View {
    TextField("", text: presenter.$interactor.viewState)
      .font(.custom("Metropolis Regular", size: 14.0))
  }
  
  private var queryFieldView: some View {
    TextField("", text: presenter.textFieldDisabled ? .constant("") : $presenter.query, onCommit: presenter.isFilterSearch ? presenter.makeSpotFinderSearchAction : presenter.makeSearchAction)
      .foregroundColor(.white)
      .font(.custom("Metropolis Regular", size: 14.0))
  }
  
  private var dropdownView: some View {
    VStack(spacing: 0) {
      VStack(spacing: 0) {
        HStack(spacing: 0) {
          Image("filterIcon")
          Text("Filter By")
            .font(.custom("Metropolis Regular", size: 12.0))
            .foregroundColor(.white)
            .padding(.leading, 10)
          Spacer()
        }
      }
      .padding(.horizontal, 18)
      VStack(alignment: .leading, spacing: 0) {
        presenter.makeSeparatorLineView()
          .opacity(0.20)
          .padding(.vertical, 10)
        Text("Time of Day")
          .font(.custom("Metropolis Semi Bold", size: 14.0))
          .foregroundColor(.white)
        BubbleDropdown(dropdownWidth: screenWidth-64, dropdownHeight: 37.0, expand: $presenter.timeDropdownIsShowing, options: $presenter.timeDropdownOptions, currentOption: $presenter.currentTimeDropdownOption, cellBackgroundColor: Color("appBackground"), cellColor: Color.white, cellColorOpacity: 0.15, fontColor: Color.white, outlineColor: Color.white, outlineOpacity: 0.15, arrowImage: Image("arrowIconWhite"))
          .padding(.top, 8)
        BubbleDropdownUnderlay(dropdownWidth: screenWidth-64, dropdownHeight: 37.0, expand: $presenter.timeDropdownIsShowing, options: $presenter.timeDropdownOptions, currentOption: $presenter.currentTimeDropdownOption, cellBackgroundColor: Color("appBackground"), cellColor: Color.white, cellColorOpacity: 0.15, fontColor: Color.white, outlineColor: Color.white, outlineOpacity: 0.15, arrowImage: Image("arrowIconWhite"))
      }
      .padding(.horizontal, 18)
      VStack(alignment: .leading, spacing: 0) {
        presenter.makeSeparatorLineView()
          .opacity(0.20)
          .padding(.vertical, 10)
        Text("Lighting")
          .font(.custom("Metropolis Semi Bold", size: 14.0))
          .foregroundColor(.white)
        presenter.makeSlider(binding: $presenter.lightingSlider)
        HStack {
          Spacer()
          Text("Dim")
            .font(.custom("Metropolis Regular", size: presenter.lightingSlider < 0.25 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Soft")
            .font(.custom("Metropolis Regular", size: 0.25 < presenter.lightingSlider && presenter.lightingSlider <= 0.5 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Bright")
            .font(.custom("Metropolis Regular", size: 0.50 < presenter.lightingSlider && presenter.lightingSlider <= 0.75 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Vibrant")
            .font(.custom("Metropolis Regular", size: 0.75 < presenter.lightingSlider ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
        }
      }
      .padding(.horizontal, 18)
      VStack(alignment: .leading, spacing: 0) {
        presenter.makeSeparatorLineView()
          .opacity(0.20)
          .padding(.vertical, 10)
        Text("Crowd")
          .font(.custom("Metropolis Semi Bold", size: 14.0))
          .foregroundColor(.white)
        presenter.makeSlider(binding: $presenter.crowdSlider)
        HStack {
          Spacer()
          Text("Exclusive")
            .font(.custom("Metropolis Regular", size: presenter.crowdSlider < 0.25 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Quaint")
            .font(.custom("Metropolis Regular", size: 0.25 < presenter.crowdSlider && presenter.crowdSlider <= 0.5 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Popular")
            .font(.custom("Metropolis Regular", size: 0.50 < presenter.crowdSlider && presenter.crowdSlider <= 0.75 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Packed")
            .font(.custom("Metropolis Regular", size: 0.75 < presenter.crowdSlider ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
        }
      }
      .padding(.horizontal, 18)
      VStack(alignment: .leading, spacing: 0) {
        presenter.makeSeparatorLineView()
          .opacity(0.20)
          .padding(.vertical, 10)
        Text("Chat")
          .font(.custom("Metropolis Semi Bold", size: 14.0))
          .foregroundColor(.white)
        presenter.makeSlider(binding: $presenter.chatSlider)
        HStack {
          Spacer()
          Text("Silent")
            .font(.custom("Metropolis Regular", size: presenter.chatSlider < 0.25 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Talkative")
            .font(.custom("Metropolis Regular", size: 0.25 < presenter.chatSlider && presenter.chatSlider <= 0.5 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Poppin'")
            .font(.custom("Metropolis Regular", size: 0.50 < presenter.chatSlider && presenter.chatSlider <= 0.75 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Loud")
            .font(.custom("Metropolis Regular", size: 0.75 < presenter.chatSlider ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
        }
      }
      .zIndex(0)
      .padding(.horizontal, 18)
    }
  }
  
  private var locationModal: some View {
    ZStack(alignment: .top) {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color.white)
        .shadow(radius: 12)
      RoundedRectangle(cornerRadius: 15.0)
        .stroke(Color("viewBackground"), lineWidth: 0.5)
      VStack(spacing: 0) {
        HStack(spacing: 0) {
          Image("locationPinIcon")
            .padding(.trailing, 8)
          Text("Change Location")
            .font(.custom("Metropolis Semi Bold", size: 14.0))
            .padding(.leading, 8)
          Spacer()
          Image("xIcon")
            .onTapGesture(count: 1, perform: {
              withAnimation(.linear(duration: 0.14)) {
                presenter.isLocationModal = false
                presenter.isBackgroundBlur = false
                presenter.isBackgroundDisabled = false
              }
            })
        }
        .padding(.top, 16)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        BubbleTextField(text:  presenter.$interactor.viewCity, disabled: .constant(false), textFieldView: cityFieldView, placeholder: "Enter City", placeholderFontColor: Color("placeholderText"), ifBorder: true, borderColor: Color("bubbleTextFieldOutline"), cornerRad: 100.0)
          .frame(height: 38)
          .padding(.horizontal, 16)
          .padding(.bottom, presenter.isLocationCityEmptyError ? 1 : 7)
        if self.presenter.isLocationCityEmptyError {
          Text("City field is empty")
            .font(.custom("Metropolis Semi Bold", size: 12))
            .foregroundColor(Color.red)
        }
        BubbleTextField(text: presenter.$interactor.viewState, disabled: .constant(false), textFieldView: stateFieldView, placeholder: "Enter State", placeholderFontColor: Color("placeholderText"), ifBorder: true, borderColor: Color("bubbleTextFieldOutline"), cornerRad: 100.0)
          .frame(height: 38)
          .padding(.horizontal, 16)
          .padding(.top, presenter.isLocationCityEmptyError ? 1 : 7)
          .padding(.bottom, presenter.isLocationStateEmptyError ? 1 : 13)
        if self.presenter.isLocationStateEmptyError {
          Text("State field is empty")
            .font(.custom("Metropolis Semi Bold", size: 12))
            .foregroundColor(Color.red)
        }
        presenter.makeModalUseLocationButton(width: abs(screenWidth-64))
          .padding(.top, 6)
          .padding(.bottom, 7)
        presenter.makeModalApplyButton(width: abs(screenWidth-64))
          .padding(.top, 7)
          .padding(.bottom, 20)
      }
    }
    .zIndex(10.0)
    .frame(width: abs(screenWidth-32), height: 250)
    .offset(y: 100)
  }
  
  private var recentlyReviewedSection: some View {
    VStack(spacing: 0) {
      presenter.makeRecentlyReviewedHeader()
      Group() {
        if self.presenter.isRecentlyReviewedLoading {
          LoadingAnimation(isAnimated: $presenter.isRecentlyReviewedLoadingAnimation, overlayHeight: 130, overlayWidth: 130, animationHeight: 100, animationWidth: 100)
            .zIndex(10.0)
        } else {
          if presenter.isRecentlyReviewedResults {
            presenter.makeRecentlyReviewedSection(cellWidth: abs(screenWidth-160.0))
          } else {
//            presenter.makeRecentlyReviewedSection(cellWidth: abs(screenWidth-160.0))
            presenter.makeRecentlyReviewedSectionZeroState()
          }
        }
      }
    }
  }
  
  private var nearbySpotsSection: some View {
    VStack(spacing: 0) {
      presenter.makeNearbySpotsHeader()
      Group() {
        if self.presenter.isNearbySpotsLoading {
          LoadingAnimation(isAnimated: $presenter.isNearbySpotsLoadingAnimation, overlayHeight: 130, overlayWidth: 130, animationHeight: 100, animationWidth: 100)
            .zIndex(10.0)
        } else {
          if presenter.isNearbySpotsResults {
            presenter.makeNearbySpotsSection(cellWidth: abs(screenWidth-40.0))
          } else {
//            presenter.makeNearbySpotsSection(cellWidth: abs(screenWidth-40.0))
            presenter.makeNearbySpotsZeroState()
          }
        }
      }
    }
    .ignoresSafeArea(edges: .bottom)
  }
  
}






struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    let locationModel = LocationModel()
    let reviewModel = ReviewModel.sampleModel
    let spotModel = SpotModel.sampleModel
    let recentlyReviewedSpotModel = SpotModel.sampleModel
    let nearbySpotModel = SpotModel.sampleModel
    let userModel = UserLoginModel.sampleModel
    let imageDownloadService = ImageDownloadService()
    let locationService = UserLocationService()
    let searchService = SpotNameSearch()
    let spotFinderService = SpotFinderSearch()
    let nearbySpotService = NearbySpots()
    let recentlyReviewedService = RecentlyReviewedSpots()
    let interactor = HomeInteractor(
      locationModel: locationModel,
      reviewModel: reviewModel,
      spotModel: spotModel,
      recentlyReviewedSpotModel: recentlyReviewedSpotModel,
      nearbySpotModel: nearbySpotModel,
      userModel: userModel,
      imageDownloadService: imageDownloadService,
      locationService: locationService,
      searchService: searchService,
      spotFinderService: spotFinderService,
      nearbySpotService: nearbySpotService,
      recentlyReviewedService: recentlyReviewedService)
    let presenter = HomePresenter(interactor: interactor)
    return HomeView(presenter: presenter)
  }
}

