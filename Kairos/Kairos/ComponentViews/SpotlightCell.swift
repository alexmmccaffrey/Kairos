//
//  SpotlightCell.swift
//  Kairos
//
//  Created by Alex McCaffrey on 11/29/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct SpotlightCell: View {
  
  let cellWidth: CGFloat
  let cellHeight: CGFloat
  
  var spotName: String = "Spot name not found"
  var spotCategory: String = "Spot category not found"
  var spotAddress: String = "Spot address not found"
  var image: UIImage?
  
  
  var body: some View {
    ZStack(alignment: .top) {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color.white)
        .frame(width: cellWidth, height: cellHeight)
        .shadow(color: Color.black.opacity(0.15), radius: 15, x: 0.0, y: 4.0)
        .shadow(color: Color.black.opacity(0.10), radius: 15, x: 0.0, y: -1.0)
      VStack(spacing: 0) {
        Image(uiImage: image ?? UIImage(imageLiteralResourceName: "itemNotFound"))
          .resizable()
          .scaledToFill()
          .aspectRatio(1.0, contentMode: .fill)
          .frame(width: cellWidth, height: cellHeight-55)
          .clipShape(RoundedRectangle(cornerRadius: 15.0))
        makeCellBottomSection()
      }
//      .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 10.0, trailing: 0.0))
    }
    .frame(width: cellWidth, height: cellHeight)
  }
}

extension SpotlightCell {
  func makeCellBottomSection() -> some View {
    HStack(spacing: 0) {
      VStack(alignment: .leading, spacing: nil){
        Text(spotName)
          .font(.custom("Metropolis Semi Bold", size: 14.0))
          .foregroundColor(Color("darkFont"))
        Spacer()
        Text(spotAddress)
          .font(.custom("Metropolis Regular", size: 12.0))
          .foregroundColor(Color("loginSelection"))
      }
      Spacer()
      VStack(spacing: 0) {
        Spacer()
        Image("arrowIconRight")
      }
    }
    .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
  }
}
