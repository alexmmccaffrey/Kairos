//
//  LoadingAnimation.swift
//  Kairos
//
//  Created by Alex McCaffrey on 12/18/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

struct LoadingAnimation: View {
  
  @Binding var isAnimated: Bool
  
  let overlayHeight: CGFloat
  let overlayWidth: CGFloat
  let animationHeight: CGFloat
  let animationWidth: CGFloat
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 15.0)
        .fill(Color.white)
        .shadow(color: Color.black.opacity(0.15), radius: 15, x: 0.0, y: 4.0)
        .shadow(color: Color.black.opacity(0.10), radius: 15, x: 0.0, y: 1.0)
      Circle()
        .stroke(Color(.systemGray5), lineWidth: 14)
        .frame(width: animationWidth, height: animationHeight)
      ZStack {
        Circle()
          .trim(from: 0.20, to: 0.80)
          .stroke(Color("sliderColor"), lineWidth: 4)
        Circle()
          .trim(from: 0.85, to: 0.90)
          .stroke(Color("secondaryButton"), lineWidth: 5)
        Circle()
          .trim(from: 0.25, to: 0.85)
          .stroke(Color("appBackground"), lineWidth: 6)
      }
      .frame(width: animationWidth, height: animationHeight)
      .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
      .animation(Animation.easeInOut(duration: 0.75).repeatForever(autoreverses: false))
      .onAppear() {
        DispatchQueue.main.async {
          self.isAnimated = true
        }
      }
      .onDisappear() {
        DispatchQueue.main.async {
          self.isAnimated = false
        }
      }
    }
    .frame(width: overlayWidth, height: overlayHeight)
  }
}
