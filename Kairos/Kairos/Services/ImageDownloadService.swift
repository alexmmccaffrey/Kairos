//
//  ImageDownloadService.swift
//  Kairos
//
//  Created by Alex McCaffrey on 12/7/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import SwiftUI

class ImageDownloadService {
  
  func imageDownload(imageUrl: String, completion: @escaping (ImageDownloadResponse) -> Void) {
    
    let url = URL(string: imageUrl)
    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    
    let session = URLSession(configuration: .default)
    
    let task = session.dataTask(with: request) {
      (data, response, error) in
      if let data = data {
        do {
          guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw self.errorHandler()
          }
          guard let image = UIImage(data: data) else {
            throw self.errorHandler()
          }
          completion(ImageDownloadResponse.success(image))
        } catch let error {
          completion(ImageDownloadResponse.failure(error))
        }
      }
    }
    task.resume()
  }
  
  enum ImageDownloadResponse: Error {
    case success(UIImage)
    case failure(Error)
  }
  
  enum ImageDownloadError: Error {
    case genericError
  }
  
  func errorHandler() -> Error {
    let error = ImageDownloadError.genericError
    return error
  }
  
}


//
//import Foundation
//import UIKit
//import Combine
//
//enum ImageDownloader {
//static func download(url: String) {
//  let url = URL(string: url)
//
//  return URLSession.shared.dataTaskPublisher(for: url!)
//    .tryMap { response -> Data in
//      guard
//        let httpURLResponse = response.response as? HTTPURLResponse,
//        httpURLResponse.statusCode == 200
//        else {
//          throw GameError.statusCode
//      }
//
//      return response.data
//    }
//    .tryMap { data in
//      guard let image = UIImage(data: data) else {
//        throw GameError.invalidImage
//      }
//      return image
//    }
//    .mapError { GameError.map($0) }
//    .eraseToAnyPublisher()
//    }
//}
