//
//  SpotSearchView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 7/27/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct SpotSearchView: View {
  @ObservedObject var presenter: SpotSearchPresenter
  
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  
  @GestureState var isTap: Bool = false
  
  var body: some View {
    GeometryReader { GeometryProxy in
      VStack(spacing: 0) {
        ScrollView {
          VStack(spacing: 0) {
            ForEach(presenter.interactor.spotModel.spots ?? []) { spot in
              WideSpotCell(cellWidth: abs(GeometryProxy.size.width-32), spotName: spot.name, spotCategory: spot.category ?? "Spot category not found", spotAddress: spot.address ?? "Spot address not found", image: spot.image)
                  .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    self.presenter.interactor.spotModel.spot = spot
                    self.presenter.viewNavigation = 1
                    print(self.presenter.interactor.spotModel.spot)
                })
                  .padding(.top, 20)
            }
            presenter.spotDetailLink(selection: $presenter.viewNavigation)
          }
          .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 30.0, trailing: 0.0))
          .frame(width: GeometryProxy.size.width, alignment: .top)
          .navigationBarBackButtonHidden(true)
          .navigationBarItems(leading: Button(action : {
              self.mode.wrappedValue.dismiss()
          }){
              Image("arrowIconLeft")
          })
          .navigationBarTitle("Spot Search")
          .navigationBarTitleDisplayMode(.inline)
        }
      }
      .edgesIgnoringSafeArea(.bottom)
      .background(Color.white)
    }
  }
}

struct SpotSearchView_Previews: PreviewProvider {
  static var previews: some View {
    let model = SpotModel.sampleModel
    let userModel = UserLoginModel.sampleModel
    let service = SpotNameSearch()
    let interactor = SpotSearchInteractor(
      spotModel: model,
      userModel: userModel,
      service: service)
    let presenter = SpotSearchPresenter(interactor: interactor)
    return SpotSearchView(presenter: presenter)
  }
}

