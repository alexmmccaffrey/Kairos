//
//  SpotDetailView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct SpotDetailView: View {
  
  @ObservedObject var presenter: SpotDetailPresenter
  
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @GestureState private var dragOffset = CGSize.zero
  
  @State var dropdownFrame = [CGRect](repeating: .zero, count: 1)
  
  var body: some View {
    GeometryReader { GeometryProxy in
      VStack(spacing: 0) {
        ZStack(alignment: .topLeading) {
          if self.presenter.isDropdown {
            BubbleDropdownUnderlay(dropdownWidth: abs(GeometryProxy.size.width - 200), dropdownHeight: 30.0, expand: $presenter.isDropdown, options: $presenter.timeDropdownOptions, currentOption: $presenter.currentTimeDropdownOption)
              .offset(x: dropdownFrame[0].minX, y: dropdownFrame[0].minY+22)
              .zIndex(20.0)
          }
          RoundedRectangle(cornerRadius: 15.0)
            .fill(Color.white)
            .frame(alignment: .top)
            .shadow(color: Color.black.opacity(0.15), radius: 15, x: 0.0, y: 4.0)
            .shadow(color: Color.black.opacity(0.10), radius: 15, x: 0.0, y: 1.0)
          VStack(spacing: 0) {
            Image(uiImage: presenter.getSpotImage() ?? UIImage(imageLiteralResourceName: "itemNotFound"))
              .resizable()
              .scaledToFill()
              .aspectRatio(1.0, contentMode: .fill)
              .frame(width: abs(GeometryProxy.size.width-32), height: 180)
              .clipShape(RoundedRectangle(cornerRadius: 15.0))
            VStack(spacing: 0) {
              Text(self.presenter.getSpotName())
                .font(.custom("Metropolis Semi Bold", size: 14.0))
                .padding(.leading, 13)
                .padding(.top, 10)
                .padding(.bottom, 5)
                .frame(width: abs(GeometryProxy.size.width-32), alignment: .leading)
            }
            .zIndex(25)
            HStack(spacing: 0) {
              Image("locationPinIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 14,height: 18)
              Text(self.presenter.getSpotAddress())
                .font(.custom("Metropolis Regular", size: 12.0))
                .padding(.leading, 8)
            }
            .padding(.leading, 10)
            .frame(width: abs(GeometryProxy.size.width-32), alignment: .leading)
            presenter.makeSeparatorLineView()
              .padding(.vertical, 8)
            HStack(alignment: .center, spacing: 0) {
              Image("timeIcon")
              Text("Time of Day:")
                .font(.custom("Metropolis Regular", size: 12.0))
                .padding(.leading, 8)
              Spacer()
              GeometryReader { dropdownGeometryProxy in
                VStack(spacing: 0) {
                  BubbleDropdown(dropdownWidth: abs(GeometryProxy.size.width - 200), dropdownHeight: 30.0, expand: $presenter.isDropdown, options: $presenter.timeDropdownOptions, currentOption: $presenter.currentTimeDropdownOption)
                    .onAppear {
                      self.dropdownFrame[0] = dropdownGeometryProxy.frame(in: .named("innerSection"))
                    }
                }
                
              }
              .frame(width: abs(GeometryProxy.size.width - 200), height: 30.0)
              .padding(.vertical, 6)
            }
            .padding(.horizontal, 10)
            .zIndex(25)
            presenter.makeSeparatorLineView()
              .padding(.vertical, 8)
            HStack {
              self.presenter.makeLightRatingSection(width: GeometryProxy.size.width/4)
              Spacer()
              self.presenter.makeCrowdRatingSection(width: GeometryProxy.size.width/4)
              Spacer()
              self.presenter.makeChatRatingSection(width: GeometryProxy.size.width/4)
            }
            .padding(.vertical, 7)
            .padding(.horizontal, 10)
            presenter.makeSubmitButton(width: abs(GeometryProxy.size.width-52))
              .padding(.top, 15)
              .padding(.bottom, 13)
            presenter.buildReviewViewLink(selection: $presenter.navigationTag)
          }
        }
        .frame(width: abs(GeometryProxy.size.width-32), height: 440)
        .padding(.top, 15)
        Spacer()
      }
      .coordinateSpace(name: "innerSection")
      .frame(width: GeometryProxy.size.width, height: GeometryProxy.size.height)
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(leading: Button(action : {
          self.mode.wrappedValue.dismiss()
      }){
          Image("arrowIconLeft")
      })
      .navigationBarTitle("Spot Details")
      .navigationBarTitleDisplayMode(.inline)
      .background(Color("viewBackground"))
    }
  }
}

struct SpotDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let model = SpotModel.sampleModel
    let service = SpotReviewService()
    let interactor = SpotDetailInteractor(model: model, service: service)
    let presenter = SpotDetailPresenter(interactor: interactor)
    return SpotDetailView(presenter: presenter)
  }
}
