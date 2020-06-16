//
//  ReviewFlowView.swift
//  Kairos
//
//  Created by Alex McCaffrey on 3/25/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

//import SwiftUI
//
//struct ReviewTimeView: View {
//  @State var selection: Int? = nil
//  @State var newReview = ReviewCreator()
//  var body: some View {
//    VStack {
//      NavigationLink(destination: ReviewLightView(newReview: $newReview), tag: 1, selection: $selection) {
//        Button(action: {
//          self.newReview.createReview.time = .morning
//          print(self.newReview.createReview.light)
//          print(self.newReview.createReview.time)
//          print(self.newReview.createReview.crowd)
//          print(self.newReview.createReview.talkable)
//          self.selection = 1
//        }) {
//          Text("Morning")
//        }
//      }
//      NavigationLink(destination: ReviewLightView(newReview: $newReview), tag: 2, selection: $selection) {
//        Button(action: {
//          self.newReview.createReview.time = .noon
//          self.selection = 2
//        }) {
//          Text("Noon")
//        }
//      }
//      NavigationLink(destination: ReviewLightView(newReview: $newReview), tag: 3, selection: $selection) {
//        Button(action: {
//          self.newReview.createReview.time = .afternoon
//          print(self.newReview.createReview.light)
//          self.selection = 3
//        }) {
//          Text("Afternoon")
//        }
//      }
//      NavigationLink(destination: ReviewLightView(newReview: $newReview), tag: 4, selection: $selection) {
//        Button(action: {
//          self.newReview.createReview.time = .evening
//          self.selection = 4
//        }) {
//          Text("Evening")
//        }
//      }
//      NavigationLink(destination: ReviewLightView(newReview: $newReview), tag: 5, selection: $selection) {
//        Button(action: {
//          self.newReview.createReview.time = .lateNight
//          self.selection = 5
//        }) {
//          Text("Late Night")
//        }
//      }
////      Child Views
////      ReviewLightView(newReview: $newReview)
//    }
//  }
//}
//
//struct ReviewLightView: View {
//  ///
//  @State var selection: Int? = nil
//  @Binding var newReview: ReviewCreator
//  ///
//  var body: some View {
//    VStack {
//      NavigationLink(destination: ReviewCrowdView(newReview: $newReview), tag: 1, selection: $selection) {
//        Button(action: {
//          self.newReview.createReview.light = .glimmering
//          print(self.newReview.createReview.light)
//          print(self.newReview.createReview.time)
//          print(self.newReview.createReview.crowd)
//          print(self.newReview.createReview.talkable)
//          self.selection = 1
//        }) {
//          Text("Glimmering")
//        }
//      }
//    NavigationLink(destination: ReviewCrowdView(newReview: $newReview), tag: 2, selection: $selection) {
//      Button(action: {
//        self.newReview.createReview.light = .neutral
//        self.selection = 2
//      }) {
//        Text("Bright")
//      }
//    }
//    NavigationLink(destination: ReviewCrowdView(newReview: $newReview), tag: 3, selection: $selection) {
//      Button(action: {
//        self.newReview.createReview.light = .moody
//        self.selection = 3
//      }) {
//        Text("Moody")
//      }
//    }
//    NavigationLink(destination: ReviewCrowdView(newReview: $newReview), tag: 4, selection: $selection) {
//      Button(action: {
//        self.newReview.createReview.light = .dark
//        self.selection = 4
//      }) {
//        Text("Dark")
//        }
//      }
//    }
//  }
//}
//
//struct ReviewCrowdView: View {
//  ///
//  @State var selection: Int? = nil
//  @Binding var newReview: ReviewCreator
//  ///
//  var body: some View {
//    VStack {
//      NavigationLink(destination: ReviewTalkableView(newReview: $newReview), tag: 1, selection: $selection) {
//        Button(action: {
//          self.newReview.createReview.crowd = .relaxed
//          print(self.newReview.createReview.light)
//          print(self.newReview.createReview.time)
//          print(self.newReview.createReview.crowd)
//          print(self.newReview.createReview.talkable)
//          self.selection = 1
//        }) {
//          Text("Relaxed")
//        }
//      }
//      NavigationLink(destination: ReviewTalkableView(newReview: $newReview), tag: 2, selection: $selection) {
//        Button(action: {
//          self.newReview.createReview.crowd = .lively
//          self.selection = 2
//        }) {
//          Text("Lively")
//        }
//      }
//      NavigationLink(destination: ReviewTalkableView(newReview: $newReview), tag: 3, selection: $selection) {
//        Button(action: {
//          self.newReview.createReview.crowd = .rowdy
//          self.selection = 3
//        }) {
//          Text("Excited")
//        }
//      }
//    }
//  }
//}
//
//struct ReviewTalkableView: View {
//  ///
//  @State var selection: Int? = nil
//  @Binding var newReview: ReviewCreator
//  ///
//  var body: some View {
//    VStack {
//      NavigationLink(destination: ContentView(), tag: 1, selection: $selection) {
//        Button(action: {
//          self.newReview.createReview.talkable = .casual
//          print(self.newReview.createReview.light)
//          print(self.newReview.createReview.time)
//          print(self.newReview.createReview.crowd)
//          print(self.newReview.createReview.talkable)
//          self.selection = 1
//        }) {
//          Text("Greatconvo")
//        }
//      }
//      NavigationLink(destination: ContentView(), tag: 2, selection: $selection) {
//        Button(action: {
//          self.newReview.createReview.talkable = .loud
//          self.selection = 2
//        }) {
//          Text("Loud")
//        }
//      }
//      NavigationLink(destination: ContentView(), tag: 3, selection: $selection) {
//        Button(action: {
//          self.newReview.createReview.talkable = .veryquiet
//          self.selection = 3
//        }) {
//          Text("Quiet")
//        }
//      }
//    }
//  }
//}
//
//struct ReviewFlowView_Previews: PreviewProvider {
//  static var previews: some View {
//    ReviewTimeView()
//  }
//}
