//
//  BuildReviewView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/7/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI
import Sliders

struct BuildReviewView: View {
  
  @ObservedObject var presenter: BuildReviewPresenter
  
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  
  @State var dropdownFrame = [CGRect](repeating: .zero, count: 1)
  

  var body: some View {
    GeometryReader { GeometryProxy in
      VStack(spacing: 0) {
        ZStack(alignment: .top) {
          if self.presenter.isLoading {
            LoadingAnimation(isAnimated: $presenter.isLoadingAnimation, overlayHeight: 130, overlayWidth: 130, animationHeight: 100, animationWidth: 100)
              .zIndex(100)
              .offset(y: 150)
          }
          RoundedRectangle(cornerRadius: 15.0)
            .fill(Color.white)
            .shadow(color: Color.black.opacity(0.15), radius: 15, x: 0.0, y: 4.0)
            .shadow(color: Color.black.opacity(0.10), radius: 15, x: 0.0, y: 1.0)
          VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
              presenter.makeSpotInfoImage(width: abs(GeometryProxy.size.width - 32))
              presenter.makeSpotInfoSectionName()
                .font(.custom("Metropolis Semi Bold", size: 14.0))
                .padding(.vertical, 7)
                .offset(x: 20)
              presenter.makeSeparatorLineView()
            }
            Rectangle()
              .fill(Color.white)
              .frame(height: GeometryProxy.size.height >= 682 ? 89 : 84)
            VStack(alignment: .center, spacing: 0) {
              presenter.makeSeparatorLineView()
                .padding(.bottom, GeometryProxy.size.height >= 682 ? 6 : 2)
              VStack(alignment: .leading, spacing: 0) {
                Text("What was the lighting like?")
                  .font(.custom("Metropolis Medium", size: GeometryProxy.size.height >= 682 ? 13.0 : 12.0))
                  .padding(.top, GeometryProxy.size.height >= 682 ? 6 : 2)
                  .padding(.bottom, 6)
                presenter.makeSlider(binding: $presenter.lightSlider)
                  .frame(width: abs(GeometryProxy.size.width - 80))
                  .padding(.top, GeometryProxy.size.height >= 682 ? 6 : 2)
                  .padding(.bottom, 6)
              }
              HStack(alignment: .center) {
                Text("Dim")
                  .font(.custom("Metropolis Regular", size: presenter.lightSlider < 0.25 ? 16.0 : 12.0))
                  .frame(width: abs((GeometryProxy.size.width - 100)/4))
                Text("Soft")
                  .font(.custom("Metropolis Regular", size: 0.25 < presenter.lightSlider && presenter.lightSlider <= 0.5 ? 16.0 : 12.0))
                  .frame(width: abs((GeometryProxy.size.width - 100)/4))
                Text("Bright")
                  .font(.custom("Metropolis Regular", size: 0.5 < presenter.lightSlider && presenter.lightSlider <= 0.75 ? 16.0 : 12.0))
                  .frame(width: abs((GeometryProxy.size.width - 100)/4))
                Text("Vibrant")
                  .font(.custom("Metropolis Regular", size: 0.75 < presenter.lightSlider ? 16.0 : 12.0))
                  .frame(width: abs((GeometryProxy.size.width - 100)/4))
              }
              .padding(.bottom, 12)
            }
            .frame(height: GeometryProxy.size.height >= 682 ? 104 : 74)
            VStack(alignment: .center, spacing: 0) {
              presenter.makeSeparatorLineView()
                .padding(.bottom, GeometryProxy.size.height >= 682 ? 6 : 2)
              VStack(alignment: .leading, spacing: 0) {
                Text("How crowded was it?")
                  .padding(.top, GeometryProxy.size.height >= 682 ? 6 : 2)
                  .padding(.bottom, 6)
                  .font(.custom("Metropolis Medium", size: GeometryProxy.size.height >= 682 ? 13.0 : 12.0))
                presenter.makeSlider(binding: $presenter.crowdSlider)
                  .padding(.top, GeometryProxy.size.height >= 682 ? 6 : 2)
                  .padding(.bottom, 6)
                  .frame(width: abs(GeometryProxy.size.width - 80))
              }
              HStack(alignment: .center) {
                Text("Exclusive")
                  .font(.custom("Metropolis Regular", size: presenter.crowdSlider < 0.25 ? 16.0 : 12.0))
                  .frame(width: abs((GeometryProxy.size.width - 100)/4))
                Text("Quaint")
                  .font(.custom("Metropolis Regular", size: 0.25 < presenter.crowdSlider && presenter.crowdSlider <= 0.5 ? 16.0 : 12.0))
                  .frame(width: abs((GeometryProxy.size.width - 100)/4))
                Text("Popular")
                  .font(.custom("Metropolis Regular", size: 0.5 < presenter.crowdSlider && presenter.crowdSlider <= 0.75 ? 16.0 : 12.0))
                  .frame(width: abs((GeometryProxy.size.width - 100)/4))
                Text("Packed")
                  .font(.custom("Metropolis Regular", size: 0.75 < presenter.crowdSlider ? 16.0 : 12.0))
                  .frame(width: abs((GeometryProxy.size.width - 100)/4))
              }
              .padding(.bottom, 12)
            }
            .frame(height: GeometryProxy.size.height >= 682 ? 104 : 74)
            VStack(alignment: .center, spacing: 0) {
              presenter.makeSeparatorLineView()
                .padding(.bottom, GeometryProxy.size.height >= 682 ? 6 : 2)
              VStack(alignment: .leading, spacing: 0) {
                Text("How easy was it to have a conversation?")
                  .padding(.top, GeometryProxy.size.height >= 682 ? 6 : 2)
                  .padding(.bottom, 6)
                  .font(.custom("Metropolis Medium", size: GeometryProxy.size.height >= 682 ? 13.0 : 12.0))
                presenter.makeSlider(binding: $presenter.chatSlider)
                  .padding(.top, GeometryProxy.size.height >= 682 ? 6 : 2)
                  .padding(.bottom, 6)
                  .frame(width: abs(GeometryProxy.size.width - 80))
              }
              HStack(alignment: .center) {
                Text("Silent")
                  .font(.custom("Metropolis Regular", size: presenter.chatSlider < 0.25 ? 16.0 : 12.0))
                  .frame(width: abs((GeometryProxy.size.width - 100)/4))
                Text("Talkative")
                  .font(.custom("Metropolis Regular", size: 0.25 < presenter.chatSlider && presenter.chatSlider <= 0.5 ? 16.0 : 12.0))
                  .frame(width: abs((GeometryProxy.size.width - 100)/4))
                Text("Poppin'")
                  .font(.custom("Metropolis Regular", size: 0.5 < presenter.chatSlider && presenter.chatSlider <= 0.75 ? 16.0 : 12.0))
                  .frame(width: abs((GeometryProxy.size.width - 100)/4))
                Text("Loud")
                  .font(.custom("Metropolis Regular", size: 0.75 < presenter.chatSlider ? 16.0 : 12.0))
                  .frame(width: abs((GeometryProxy.size.width - 100)/4))
              }
              .padding(.bottom, 12)
            }
            .frame(height: GeometryProxy.size.height >= 682 ? 104 : 74)
            Spacer()
            /// Submit Button
            VStack(spacing: 0) {
              ZStack {
                Button(action: {
                  self.presenter.submitReviewAction() {
                    DispatchQueue.main.async {
                      self.mode.wrappedValue.dismiss()
                    }
                  }
                }, label: {
                  HStack {
                    Spacer()
                    Text("Submit")
                      .font(.custom("Metropolis Semi Bold", size: 15.0))
                    Spacer()
                  }
                  .padding(.vertical, 24)
                })
                .frame(width: abs(GeometryProxy.size.width-62), height: 37, alignment: .center)
                .foregroundColor(.white)
                .background(Color("appBackground"))
                .cornerRadius(40)
              }
              .padding(.bottom, 17)
            }
            /// End Submit Button
          }
          VStack(alignment: .center, spacing: 0) {
            HStack {
              Text("What time of day did you visit?")
                .font(.custom("Metropolis Medium", size: GeometryProxy.size.height >= 682 ? 13.0 : 12.0))
                .padding(.top, 6)
                .padding(.bottom, GeometryProxy.size.height >= 682 ? 12 : 6)
                .padding(.leading, 22)
              Spacer()
            }
            HStack(spacing: 0) {
              Spacer()
              Spacer()
              Spacer()
              GeometryReader { dropdownGeometryProxy in
                VStack(spacing: 0) {
                  BubbleDropdown(dropdownWidth: abs(GeometryProxy.size.width - 80), dropdownHeight: 30.0, expand: $presenter.isDropdown, options: $presenter.timeDropdownOptions, currentOption: $presenter.currentTimeDropdownOption)
                    .onAppear {
                      self.dropdownFrame[0] = dropdownGeometryProxy.frame(in: .named("innerSection"))
                    }
                }
              }
            }
          }
          .offset(y: 212)
          if presenter.isDropdown {
            BubbleDropdownUnderlay(dropdownWidth: abs(GeometryProxy.size.width - 80), dropdownHeight: 30.0, expand: $presenter.isDropdown, options: $presenter.timeDropdownOptions, currentOption: $presenter.currentTimeDropdownOption)
              .offset(x: dropdownFrame[0].minX-25, y: dropdownFrame[0].minY+30)
          }
        }
        .coordinateSpace(name: "innerSection")
        .frame(width: abs(GeometryProxy.size.width-32), height: GeometryProxy.size.height >= 682 ? abs(GeometryProxy.size.height-30) : abs(GeometryProxy.size.height-20))
      }
      .frame(width: GeometryProxy.size.width, height: GeometryProxy.size.height)
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(leading: Button(action : {
          self.mode.wrappedValue.dismiss()
      }){
          Image("arrowIconLeft")
      })
      .navigationBarTitle("Leave A Review")
//      .navigationBarTitleDisplayMode(.inline)
      .background(Color.white)
    }
  }
}

struct BuildReviewView_Previews : PreviewProvider {
  static var previews: some View {
    let reviewModel = ReviewModel.sampleModel
    let spotModel = SpotModel.sampleModel
    let userModel = UserLoginModel.sampleModel
    let service = BuildReviewService()
    let interactor = BuildReviewInteractor(
      reviewModel: reviewModel,
      spotModel: spotModel,
      userModel: userModel,
      reviewService: service)
    let presenter = BuildReviewPresenter(interactor: interactor)
    return BuildReviewView(presenter: presenter)
      
  }
}



