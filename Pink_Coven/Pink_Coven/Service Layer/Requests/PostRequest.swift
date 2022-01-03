//
//  PostRequest.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import Foundation
import KituraContracts

struct GetAllPostRequest: APIRequest {
   
    typealias Response = [Post]
    
    var method: HTTPMethod { return .GET }
    var path: String {return "/posts"}
    var contentType: String { return "application/json" }
    var additionalHeaders: [String : String] {return [:]}
    var body: Data? { return nil }
    var params: EmptyParams? { return nil}
    
    func handle(response: Data) throws -> [Post] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: response)
    }
    
}

struct CreateNewPostRequest: APIRequest, Codable {
    let post: Post

    init(caption: String) {
      self.post = Post(caption: caption)
    }

    typealias Response = Post

    var method: HTTPMethod { return .POST }
    var path: String { return "/posts" }
    var contentType: String { return "application/json" }
    var additionalHeaders: [String : String] {return [:]}
    var body: Data? {
      let encoder = JSONEncoder()
      encoder.dateEncodingStrategy = .iso8601
      return try? encoder.encode(post)
    }
    var params: EmptyParams? { return nil }

    func handle(response: Data) throws -> Post {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      return try decoder.decode(Response.self, from: response)
    }
}

