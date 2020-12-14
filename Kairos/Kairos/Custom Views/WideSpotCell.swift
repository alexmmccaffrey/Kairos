//
//  WideSpotCell.swift
//  Kairos
//
//  Created by Alex McCaffrey on 11/15/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct WideSpotCell: View {
  
  
  var cellWidth: CGFloat
//  @Binding var isTapped: Bool = false
  
  var spotName: String = "Spot name not found"
  var spotCategory: String = "Spot category not found"
  var spotImage: String = ""
  var image: UIImage?
  
  
  var body: some View {
    ZStack(alignment: .leading) {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color.white)
        .shadow(radius: 13.0)
      HStack(spacing: 0) {
        Image(uiImage: image ?? UIImage(imageLiteralResourceName: "itemNotFound"))
          .resizable()
          .scaledToFill()
          .aspectRatio(1.0, contentMode: .fill)
          .frame(width: 90, height: 90)
          .clipShape(RoundedRectangle(cornerRadius: 15.0))
        VStack(alignment: .leading, spacing: 0) {
          VStack(alignment: .leading, spacing: 0) {
            Text(spotName)
              .font(.custom("Metropolis Semi Bold", size: 14.0))
              .padding(.top, 12)
              .padding(.bottom, 4)
            Text(spotCategory)
              .font(.custom("Metropolis Medium", size: 12.0))
              .foregroundColor(Color("loginSelection"))
              .padding(. top, 4)
              .padding(.bottom, 8)
          }
          .frame(height: 55)
          .padding(.leading, 12)
          makeSeparatorLineView()
          HStack(spacing: 0) {
            Spacer()
            VStack(alignment: .center, spacing: 0) {
              Spacer()
              Image("arrowIconRight")
//                .renderingMode(.template)
//                .foregroundColor(.blue)
                .offset(y: 2)
                .padding(.trailing, 16)
              Spacer()
            }
          }.frame(height: 25)
        }
        Spacer()
      }
      .frame(width: cellWidth, height: 90)
    }
    .frame(width: cellWidth, height: 90, alignment: .top)
  }
  
}

extension WideSpotCell {
  
  func makeSeparatorLineView() -> some View {
    Rectangle()
      .fill(Color("bubbleTextFieldOutline"))
      .frame(height: 0.5)
  }
  
}
