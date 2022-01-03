//
//  PostController.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/2/22.
//

import UIKit
import Combine

final class PostController: ObservableObject {
  @Published var isRunning = false
  @Published var postUploaded = false
  @Published var postError = false
  var postErrorText = ""
  private var subscriptions: Set<AnyCancellable> = []

  func uploadPost(withDescription description: String, image: UIImage) {
    isRunning = true
      let client = APIClient()
    let request = CreateNewPostRequest(caption: description)
    client.publisherForRequest(request)
      .tryMap { post -> (UUID, Data) in
        guard let imageId = post.id, let imageData = image.jpegData(compressionQuality: 80) else {
          throw APIError.postProcessingFailed(nil)
        }
        return (imageId, imageData)
      }
      .flatMap { (imageId, imageData) -> AnyPublisher<Void, Error> in
        let imageRequest = UploadImageRequest(imageId: imageId, imageData: imageData)
        return client.publisherForRequest(imageRequest)
      }
      .sink(receiveCompletion: { completion in
        self.isRunning = false
          switch completion {
          case .finished:
              self.postErrorText = ""
              self.postError = false
              self.postUploaded = true
          case .failure(let error):
              self.postUploaded = false
              self.postErrorText = error.localizedDescription
              self.postError = true
              
          }
      }, receiveValue: { value in
      })
      .store(in: &subscriptions)
  }
}
