//
//  BubbleTextField.swift
//  Kairos
//
//  Created by Alex McCaffrey on 10/30/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct BubbleTextField<TextFieldView>: View where TextFieldView: View {
  
  @Binding var text: String
  let textFieldView: TextFieldView
  
  let placeholder: String
  var placeholderFontColor: Color = Color("placeholderText")
  
  var ifBorder: Bool = true
  var borderColor: Color = Color("bubbleTextFieldOutline")
  
  var leadingIconPadding: CGFloat = 16.0
  var trailingIconPadding: CGFloat = 16.0
  
  var cornerRad: CGFloat = 100.0
  
  var imageName: String? = nil
  
  
  private var isTextFieldWithIcon: Bool {
    return imageName != nil
  }
  
  var body: some View {
    ZStack {
      HStack(spacing: 0) {
        if isTextFieldWithIcon {
          iconImageView
        }
        bubbleTextFieldView
      }

      if ifBorder {
        outlineView
      }
    }
  }
}

extension BubbleTextField {
  private var outlineView: some View {
    RoundedRectangle(cornerRadius: cornerRad, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
      .strokeBorder(borderColor, lineWidth: 1)
  }
  
  private var iconImageView: some View {
    Image(imageName ?? "")
      .frame(width: 16, height: 32)
      .padding(.leading, leadingIconPadding)
      .padding(.trailing, trailingIconPadding)
  }
  
  private var bubbleTextFieldView: some View {
    VStack {
      ZStack(alignment: .leading) {
        if text.isEmpty {
          placeholderView
        }
        textFieldView
          .padding(.trailing, 16)
          .padding(.leading, isTextFieldWithIcon ? 0 : 16)
      }
    }
  }
  
  private var placeholderView: some View {
    Text(placeholder)
      .font(.custom("Metropolis Regular", size: 12))
      .foregroundColor(placeholderFontColor)
      .padding(.leading, isTextFieldWithIcon ? 0 : 16)
  }
  
}
