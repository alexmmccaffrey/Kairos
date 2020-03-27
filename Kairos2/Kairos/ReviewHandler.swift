//
//  ReviewHandler.swift
//  Kairos
//
//  Created by Alex McCaffrey on 3/25/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation


class ReviewCreator: ObservableObject {
  @Published var createReview = Review()
}
