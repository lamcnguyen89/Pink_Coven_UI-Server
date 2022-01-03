//
//  ImageRequest.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/2/22.
//

import UIKit

struct UploadImageRequest: APIRequest {
  let imageId: UUID
  let imageData: Data

  init(imageId: UUID, imageData: Data) {
    self.imageId = imageId
    self.imageData = imageData
  }

  typealias Response = Void

  var method: HTTPMethod { return .POST }
  var path: String { return "/image" }
  var body: Data? {
    return imageData
  }

  func handle(response: Data) throws -> Void {
  }
}
