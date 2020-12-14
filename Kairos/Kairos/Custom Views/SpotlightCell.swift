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
  
  var body: some View {
    
    
    ZStack {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color.white)
      VStack(spacing: 0) {
        Image("itemNotFound")
          .resizable()
          .scaledToFill()
          .aspectRatio(1.0, contentMode: .fit)
          .frame(width: cellWidth, height: abs(cellHeight - 100))
          .clipShape(RoundedRectangle(cornerRadius: 15.0))
          
        Spacer()
        HStack(spacing: 0) {
          Text("Spot Name")
            .padding(.leading, 20)
          Spacer()
          Image("arrowIconRight")
            .padding(.trailing, 30)
        }
        .padding(.bottom, 40)
      }
    }
    .frame(width: cellWidth, height: cellHeight)
  }
  
}
