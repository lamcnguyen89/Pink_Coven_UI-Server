//
//  Feed.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import Foundation
import Combine

class Feed: ObservableObject {
    @Published var posts: [Post] = []
    @Published var loadError: Error?
    var signInSubscriber: AnyCancellable?
    var getPostsSubscriber: AnyCancellable?
    
    init() {
        signInSubscriber = NotificationCenter.default.publisher(for: .signInNotification)
            .sink  { [weak self] _ in
                self?.loadFeed()
            }
    }
    
    func loadFeed() {
        let client = APIClient()
        let request = GetAllPostRequest()
        getPostsSubscriber = client.publisherForRequest(request)
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result {
                    self.loadError = error
                }
            }, receiveValue: { newPosts in
                self.posts = newPosts
            })
    }
}


