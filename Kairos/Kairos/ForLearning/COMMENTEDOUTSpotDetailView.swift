////
////  SwiftUIView.swift
////  Kairos
////
////  Created by Alex McCaffrey on 4/2/20.
////  Copyright © 2020 Alex McCaffrey. All rights reserved.
////
//
//import SwiftUI
//
//struct Test: View {
//
//  @State var timeOfDay = ["Morning", "Noon", "Afternoon", "Evening", "Late Night"]
//  @State var timeOfDaySelected = 4
//  @State var timePickerVisible = false
//
//  var body: some View {
//    GeometryReader { GeometryProxy in
/////
///// Time of Day dropdown
/////
//
//      VStack(alignment: .leading) {
//        Spacer().frame(height: 25)
//        HStack() {
//          Text("Time of Day")
//          Button(self.timeOfDay[self.timeOfDaySelected]) {
//              self.timePickerVisible.toggle()
//          }
//        }.padding(.top, 10)
//        if self.timePickerVisible == true {
//          HStack{
//            Picker(selection: self.$timeOfDaySelected, label: Text("")) {
//              ForEach(0..<self.timeOfDay.count) {
//                Text(self.timeOfDay[$0])
//              }
//            }
//          }
//        }
//        Spacer().frame(height: 25)
/////
///// Restaurant name
/////
//        ZStack() {
//          VStack() {
//            HStack() {
//              Text("Restaurant Name")
//                .font(.custom("Montserrat-Bold", size: 23))
//                .foregroundColor(Color(hue: 0.0, saturation: 0.45, brightness: 0.96))
//                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
//              Spacer()
//            }
//            Spacer().frame(height: 8)
//            HStack() {
//              Image("DiningIcon")
//              Image("DiningIcon")
//              Spacer()
//            }
//              .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
//          }
//          .frame(width: GeometryProxy.size.width-60, height: 80)
//          .background(Color(hue: 79/360, saturation: 0.09, brightness: 0.96))
//          RoundedRectangle(cornerRadius: 5, style: .circular)
//            .stroke(Color(hue: 197/360, saturation: 0.80, brightness: 0.35), lineWidth: 5)
//        }
//        .frame(width: GeometryProxy.size.width-60, height: 80)
//        Spacer().frame(height: 25)
/////
///// Rating Stacks
/////
//        VStack() {
//          HStack(alignment: .top) {
//            ZStack() {
//              VStack(alignment: .center) {
//                Text("Crowd Icon")
//                  .font(.custom("Montserrat-Bold", size: 23))
//                  .foregroundColor(Color(hue: 0.0, saturation: 0.45, brightness: 0.96))
//                Spacer().frame(height: 12)
//                Text("Rating #")
//                 .font(.custom("Montserrat-Bold", size: 23))
//                 .foregroundColor(Color(hue: 0.0, saturation: 0.45, brightness: 0.96))
//              }
//              RoundedRectangle(cornerRadius: 5, style: .circular)
//                .stroke(Color(hue: 197/360, saturation: 0.80, brightness: 0.35), lineWidth: 5)
//            }
//              .background(Color(hue: 79/360, saturation: 0.09, brightness: 0.96))
//            Spacer()
//            Spacer()
//            ZStack() {
//              VStack(alignment: .center) {
//                Text("Lighting Icon")
//                  .font(.custom("Montserrat-Bold", size: 23))
//                  .foregroundColor(Color(hue: 0.0, saturation: 0.45, brightness: 0.96))
//                Spacer().frame(height: 12)
//                Text("Rating #")
//                 .font(.custom("Montserrat-Bold", size: 23))
//                 .foregroundColor(Color(hue: 0.0, saturation: 0.45, brightness: 0.96))
//              }
//              RoundedRectangle(cornerRadius: 5, style: .circular)
//                .stroke(Color(hue: 197/360, saturation: 0.80, brightness: 0.35), lineWidth: 5)
//            }
//              .background(Color(hue: 79/360, saturation: 0.09, brightness: 0.96))
//          }
//        }
//        .frame(width: GeometryProxy.size.width-60, height: 150)
//        Spacer()
//      }.frame(width: GeometryProxy.size.width, height: GeometryProxy.size.height).background(Color(hue: 0.0, saturation: 0.45, brightness: 0.96))
//    }
//  }
//}
//
//struct SwiftUIView_Previews: PreviewProvider {
//  static var previews: some View {
//    Test()
//  }
//}
