//
//  HomeView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/7/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Combine
import SwiftUI
import Sliders

struct HomeView: View {

  @ObservedObject var presenter: HomePresenter
  
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  
  @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
  
  var body: some View {
    NavigationView {
      GeometryReader { GeometryProxy in
        ZStack(alignment: .top) {
          VStack(spacing: 0) {
            ZStack(alignment: .top) {
              if presenter.dropdownIsShowing {
                RoundedRectangle(cornerRadius: 15.0)
                  .fill(Color("appBackground"))
                  .shadow(radius: 13)
                  .frame(height: presenter.dropdownIsShowing ? nil : 60)
                  .transition(.move(edge: .top))
              }
              VStack {
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

            
            
            /// GARBAGE
            Spacer()
            
            
            VStack {

              
              
              
              Text("Search for your favorite Spots and leave a review or...")
              presenter.logoutButton()
              presenter.makeSpotFinderSearch()
              presenter.linkSpotSearchView(selection: $presenter.viewNavigation)
              presenter.linkDateCriteriaView(selection: $presenter.viewNavigation)

              

              
              
              
              
            }
            .background(
              Color.blue
                .opacity(0.15)
            )
            
            
            Spacer()
            /// END GARBAGE
            
            
            
            VStack {
              presenter.makeGraySeparatorLineView()
              Text("Spotlight")
              SpotlightCell(cellWidth: abs(GeometryProxy.size.width-30), cellHeight: 350)
                .shadow(radius: 13)
            }
            .padding(.bottom, 40)
          }
          .frame(width: GeometryProxy.size.width, height: GeometryProxy.size.height, alignment: .top)
          .navigationBarBackButtonHidden(true)
          .navigationBarTitle("")
          .navigationBarTitleDisplayMode(.inline)
          .background(Color.white)
          .blur(radius: presenter.isLocationModal ? 10 : 0)
          
          /// Start Modal
          
          if presenter.isLocationModal {
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
                        presenter.isLocationModal.toggle()
                      }
                    })
                }
                .padding(.top, 16)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                BubbleTextField(text:  presenter.$interactor.city, textFieldView: cityFieldView, placeholder: "Enter City", placeholderFontColor: Color("placeholderText"), ifBorder: true, borderColor: Color("bubbleTextFieldOutline"), cornerRad: 100.0)
                  .frame(height: 38)
                  .padding(.horizontal, 16)
                  .padding(.bottom, 7)
                BubbleTextField(text: presenter.$interactor.state, textFieldView: stateFieldView, placeholder: "Enter State", placeholderFontColor: Color("placeholderText"), ifBorder: true, borderColor: Color("bubbleTextFieldOutline"), cornerRad: 100.0)
                  .frame(height: 38)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 7)
                presenter.makeModalUseLocationButton(width: abs(GeometryProxy.size.width-64))
                  .padding(.top, 12)
                  .padding(.bottom, 7)
                presenter.makeModalApplyButton(width: abs(GeometryProxy.size.width-64))
                  .padding(.top, 7)
                  .padding(.bottom, 20)
              }
            }
            .zIndex(10.0)
            .frame(width: abs(GeometryProxy.size.width-32), height: 250)
            .offset(y: 100)
          }

          
          /// End Modal
        }
//        .overlay(ActivityIndicator(isAnimating: .constant(presenter.overlay), style: .large))
//        .onAppear {
//          self.presenter.views = .constant(0)
//          self.presenter.overlay = false
//          self.presenter.errorMessage = false
//        }
      }
      .ignoresSafeArea(.keyboard, edges: .bottom)
      .navigationBarItems(trailing: locationButton)
    }
    .zIndex(2.0)
    .navigationBarHidden(true)
  }
}

extension HomeView {
  
  private var locationButton: some View {
    presenter.makeLocationButton()
  }
  
  private var searchBarView: some View {
    ZStack(alignment: .trailing) {
      BubbleTextField(text: $presenter.query, textFieldView: queryFieldView, placeholder: "What are you looking for?", placeholderFontColor: Color.white, ifBorder: false, leadingIconPadding: 14.0, trailingIconPadding: 10.0, cornerRad: 30.0, imageName: "searchIcon")
        .background(
          Color.white
            .opacity(0.15)
        )
        .cornerRadius(30.0)
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

  private var cityFieldView: some View {
    TextField("", text: presenter.$interactor.city)
      .font(.custom("Metropolis Regular", size: 14.0))
  }
  
  private var stateFieldView: some View {
    TextField("", text: presenter.$interactor.state)
      .font(.custom("Metropolis Regular", size: 14.0))
  }
  
  private var queryFieldView: some View {
    TextField("", text: $presenter.query, onCommit: presenter.isFilterSearch ? presenter.makeSpotFinderSearchAction : presenter.makeSearchAction)
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
          Text("Some")
            .font(.custom("Metropolis Regular", size: presenter.lightingSlider < 0.25 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Some")
            .font(.custom("Metropolis Regular", size: 0.25 < presenter.lightingSlider && presenter.lightingSlider <= 0.5 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Some")
            .font(.custom("Metropolis Regular", size: 0.50 < presenter.lightingSlider && presenter.lightingSlider <= 0.75 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Some")
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
          Text("Some")
            .font(.custom("Metropolis Regular", size: presenter.crowdSlider < 0.25 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Some")
            .font(.custom("Metropolis Regular", size: 0.25 < presenter.crowdSlider && presenter.crowdSlider <= 0.5 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Some")
            .font(.custom("Metropolis Regular", size: 0.50 < presenter.crowdSlider && presenter.crowdSlider <= 0.75 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Some")
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
          Text("Some")
            .font(.custom("Metropolis Regular", size: presenter.chatSlider < 0.25 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Some")
            .font(.custom("Metropolis Regular", size: 0.25 < presenter.chatSlider && presenter.chatSlider <= 0.5 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Some")
            .font(.custom("Metropolis Regular", size: 0.50 < presenter.chatSlider && presenter.chatSlider <= 0.75 ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
          Text("Some")
            .font(.custom("Metropolis Regular", size: 0.75 < presenter.chatSlider ? 16.0 : 12.0))
            .foregroundColor(.white)
          Spacer()
        }
      }
      .zIndex(0)
      .padding(.horizontal, 18)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    let locationModel = LocationModel()
    let reviewModel = ReviewModel.sampleModel
    let spotModel = SpotModel.sampleModel
    let userModel = UserLoginModel.sampleModel
    let imageDownloadService = ImageDownloadService()
    let locationService = UserLocationService()
    let searchService = SpotNameSearch()
    let spotFinderService = SpotFinderSearch()
    let interactor = HomeInteractor(
      locationModel: locationModel,
      reviewModel: reviewModel,
      spotModel: spotModel,
      userModel: userModel,
      imageDownloadService: imageDownloadService,
      locationService: locationService,
      searchService: searchService,
      spotFinderService: spotFinderService)
    let presenter = HomePresenter(interactor: interactor)
    return HomeView(presenter: presenter)
  }
}

