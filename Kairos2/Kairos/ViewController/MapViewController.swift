//
//  MapViewController.swift
//  Meet in the Middle
//
//  Created by Alex McCaffrey on 3/8/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import UIKit
import SwiftUI
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {

    // You don't need to modify the default init(nibName:bundle:) method.

    override func loadView() {
      // Create a GMSCameraPosition that tells the map to display the
      // coordinate -33.86,151.20 at zoom level 6.
      let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
      let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
      view = mapView

      // Creates a marker in the center of the map.
      let marker = GMSMarker()
      marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
      marker.title = "Sydney"
      marker.snippet = "Australia"
      marker.map = mapView
    }
  }

struct ViewControllerWrapper: UIViewControllerRepresentable {

    typealias UIViewControllerType = MapViewController


    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewControllerWrapper>) -> ViewControllerWrapper.UIViewControllerType {
        return MapViewController()
    }

    func updateUIViewController(_ uiViewController: ViewControllerWrapper.UIViewControllerType, context: UIViewControllerRepresentableContext<ViewControllerWrapper>) {
        //
    }
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

