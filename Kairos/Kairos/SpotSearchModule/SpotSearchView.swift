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
        ForEach(presenter.interactor.spotModel.spots ?? []) { spot in
          WideSpotCell(cellWidth: abs(GeometryProxy.size.width-32), spotName: spot.name, spotCategory: spot.category ?? "Spot category not found", image: spot.image)
            .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
              self.presenter.interactor.spotModel.spot = spot
              self.presenter.viewNavigation = 1
              print(self.presenter.interactor.spotModel.spot)
          })
            .padding(.vertical, 20)
        }
        presenter.spotDetailLink(selection: $presenter.viewNavigation)
      }
      .frame(width: GeometryProxy.size.width, height: GeometryProxy.size.height, alignment: .top)
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

struct SpotSearchView_Previews: PreviewProvider {
  static var previews: some View {
    let model = SpotModel.sampleModel
    let service = SpotNameSearch()
    let interactor = SpotSearchInteractor(spotModel: model, service: service)
    let presenter = SpotSearchPresenter(interactor: interactor)
    return SpotSearchView(presenter: presenter)
  }
}

