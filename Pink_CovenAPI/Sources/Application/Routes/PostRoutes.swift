//
//  PostRoutes.swift
//  Application
//
//  Created by Lam Nguyen on 1/2/22.
//

import Foundation
import KituraContracts

var posts: [Post] = [Post(id: UUID(), caption: "Test Post1", createdAt: Date(), createdBy: "UserName"),
                     Post(id: UUID(), caption: "Test Post2", createdAt: Date() - (60*60*4), createdBy: "Another User")]

let iso8601Decoder: () -> BodyDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}

let iso8601Encoder: () -> BodyEncoder = {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}


func initializePostRoutes(app: App) {
    app.router.get("/api/v1/posts", handler: getPosts)
    app.router.post("/api/v1/posts", handler: addPost)

    app.router.decoders[.json] = iso8601Decoder
    app.router.encoders[.json] = iso8601Encoder
    
}

func getPosts(completion: @escaping ([Post]?, RequestError?) -> Void) {
    completion(posts, nil)
}

func addPost(post: Post, completion: @escaping (Post?, RequestError?) -> Void) {
    var newPost = post
    if newPost.id == nil {
        newPost.id == UUID()
    }
    
    posts.append(newPost)
    completion(newPost, nil)
}
