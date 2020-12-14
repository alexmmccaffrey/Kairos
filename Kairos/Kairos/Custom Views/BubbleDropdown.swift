//
//  Dropdown.swift
//  Kairos
//
//  Created by Alex McCaffrey on 11/13/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct DropdownOption: Identifiable {
    var id = UUID()
    var optionName: String
  
  init(_ optionName: String) {
    self.optionName = optionName
  }
}


struct BubbleDropdown: View {
  
  let dropdownWidth: CGFloat
  let dropdownHeight: CGFloat
  @Binding var expand: Bool
  @Binding var options: [DropdownOption]
  @Binding var currentOption: DropdownOption
  
  var cellBackgroundColor: Color = Color("sliderColor")
  var fontColor: Color = Color("appBackground")
  var outlineColor: Color = Color("appBackground")
  var arrowImage: Image = Image("arrowIcon")
  
  
  var body: some View {
    VStack(spacing: 0) {
      ZStack(alignment: .leading) {
        if expand {
          ZStack {
            Rectangle()
              .fill(cellBackgroundColor)
              .opacity(0.08)
              .frame(width: dropdownWidth, height: dropdownHeight/2, alignment: .top)
              .offset(y: dropdownHeight/4)
              .onTapGesture {
                self.expand.toggle()
              }
          }
        }
        RoundedRectangle(cornerRadius: 100)
          .fill(Color.white)
          .frame(width: abs(dropdownWidth), height: dropdownHeight, alignment: .top)
        RoundedRectangle(cornerRadius: 100)
          .strokeBorder(outlineColor)
          .frame(width: abs(dropdownWidth), height: dropdownHeight, alignment: .top)
          .background(
            RoundedRectangle(cornerRadius: 100)
              .fill(cellBackgroundColor)
              .opacity(0.15)
          )
          .onTapGesture {
            self.expand.toggle()
          }
        HStack {
          Text("\(currentOption.optionName)")
            .font(.custom("Metropolis Medium", size: 12))
            .foregroundColor(fontColor)
            .padding(.leading, 19)
          Spacer()
          Spacer()
          arrowImage
            .padding(.trailing, 21)
        }
        .frame(width: dropdownWidth)
      }
      if expand {
        VStack(spacing: 0) {
          ForEach(options) { option in
            ZStack {
              Rectangle()
                .fill(Color.white)
                .frame(width: dropdownWidth, height: dropdownHeight, alignment: .top)
              Rectangle()
                .fill(cellBackgroundColor)
                .opacity(0.08)
                .frame(width: dropdownWidth, height: dropdownHeight, alignment: .top)
                .onTapGesture {
                  self.currentOption = option
                  self.expand.toggle()
                }
              Text("\(option.optionName)")
                .font(.custom("Metropolis Medium", size: 12))
                .foregroundColor(fontColor)
            }
          }
        }
      }
    }
      .animation(.linear(duration: 0.3))
      .alignmentGuide(VerticalAlignment.center) { $0[.top] }
    
  }
  
}
