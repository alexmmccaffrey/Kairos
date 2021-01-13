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
  
  func imageDownload(imageID: String, completion: @escaping (ImageDownloadResponse) -> Void) {
    
    
    let url = URL(string: genImageDownloadURL(imageID: imageID))
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
  
  func genImageDownloadURL(imageID: String) -> String {
    let prefix = "https://api.tomtom.com/search/2/poiPhoto?key=B2bpEPbGOGhv6pn3NN0X6P6Sz63BVmf1&id="
    let suffix = "&height=3000&width=3000"
    let url = prefix + imageID + suffix
    return url
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
