//
//  BubbleDropdown.swift
//  Kairos
//
//  Created by Alex McCaffrey on 11/13/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct DropdownOption: Identifiable, Equatable {
  var id = UUID()
  var timeValue: Int
  var optionName: String
  
  init(_ timeValue: Int, _ optionName: String) {
    self.timeValue = timeValue
    self.optionName = optionName
  }
}


struct BubbleDropdown: View {
  
  let dropdownWidth: CGFloat
  let dropdownHeight: CGFloat
  @Binding var expand: Bool
  @Binding var options: [DropdownOption]
  @Binding var currentOption: DropdownOption
  
  
  var cellBackgroundColor: Color = Color.white
  var cellColor: Color = Color("sliderColor")
  var cellColorOpacity: Double = 0.15
  var fontColor: Color = Color("appBackground")
  var outlineColor: Color = Color("appBackground")
  var outlineOpacity: Double = 1.00
  var arrowImage: Image = Image("arrowIcon")
  
  
  var body: some View {
    VStack(spacing: 0) {
      ZStack(alignment: .leading) {
        if expand {
          ZStack {
            Rectangle()
              .fill(cellBackgroundColor)
              .frame(width: dropdownWidth, height: dropdownHeight/2, alignment: .top)
              .frame(height: dropdownHeight/2, alignment: .top)
              .offset(y: dropdownHeight/4)
              .onTapGesture {
                self.expand.toggle()
              }
            Rectangle()
              .fill(cellColor)
              .opacity(cellColorOpacity)
              .frame(width: dropdownWidth, height: dropdownHeight/2, alignment: .top)
              .frame(height: dropdownHeight/2, alignment: .top)
              .offset(y: dropdownHeight/4)
              .onTapGesture {
                self.expand.toggle()
              }
          }
        }
        RoundedRectangle(cornerRadius: 100)
          .fill(cellBackgroundColor)
          .frame(width: abs(dropdownWidth), height: dropdownHeight, alignment: .top)
          .frame(height: dropdownHeight, alignment: .top)
        RoundedRectangle(cornerRadius: 100)
          .strokeBorder(outlineColor)
          .opacity(outlineOpacity)
          .frame(width: abs(dropdownWidth), height: dropdownHeight, alignment: .top)
          .frame(height: dropdownHeight, alignment: .top)
          
          .background(
            RoundedRectangle(cornerRadius: 100)
              .fill(cellColor)
              .opacity(cellColorOpacity)
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

    }
      .alignmentGuide(VerticalAlignment.center) { $0[.top] }
  }
}



struct BubbleDropdownUnderlay: View {
  
  let dropdownWidth: CGFloat?
  let dropdownHeight: CGFloat
  @Binding var expand: Bool
  @Binding var options: [DropdownOption]
  @Binding var currentOption: DropdownOption
  
  
  var cellBackgroundColor: Color = Color.white
  var cellColor: Color = Color("sliderColor")
  var cellColorOpacity: Double = 0.15
  var fontColor: Color = Color("appBackground")
  var outlineColor: Color = Color("appBackground")
  var outlineOpacity: Double = 1.00
  var arrowImage: Image = Image("arrowIcon")
  
  
  var body: some View {
    EmptyView()
    if expand {
      VStack(spacing: 0) {
        ForEach(options) { option in
          ZStack {
            Rectangle()
              .fill(cellBackgroundColor)
              .frame(width: dropdownWidth != nil ? dropdownWidth : nil, height: dropdownHeight, alignment: .top)
              .offset(y: option == options.last ? -dropdownHeight/4 : 0.0)
            Rectangle()
              .fill(cellColor)
              .opacity(cellColorOpacity)
              .frame(width: dropdownWidth != nil ? dropdownWidth : nil, alignment: .top)
              .offset(y: option == options.last ? -dropdownHeight/4 : 0.0)
            if option == options.last {
              RoundedRectangle(cornerRadius: 100.0)
                .fill(cellBackgroundColor)
                .frame(width: dropdownWidth != nil ? dropdownWidth : nil, height: dropdownHeight, alignment: .top)
              RoundedRectangle(cornerRadius: 100.0)
                .fill(cellColor)
                .opacity(cellColorOpacity)
                .frame(width: dropdownWidth != nil ? dropdownWidth : nil, height: dropdownHeight, alignment: .top)
            }
            Text("\(option.optionName)")
              .font(.custom("Metropolis Medium", size: 12))
              .foregroundColor(fontColor)
          }
          .onTapGesture {
            self.currentOption = option
            withAnimation(.linear(duration: 0.2)) {
              self.expand.toggle()
            }

          }
        }
      }
      .frame(height: CGFloat(options.count) * dropdownHeight)
    }
    
  }
  
}
