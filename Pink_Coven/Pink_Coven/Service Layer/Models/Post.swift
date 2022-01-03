//
//  Post.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import Foundation

// Provides the Structure for the backend data
// Model

struct Post: Codable, Identifiable {
    var id: UUID?
    // Codable is a keyword for making the object into a JSON
    var caption: String
    var createdAt: Date
    //var photoURL: URL
    var createdByUser: String
    
    init(id: UUID? = nil, caption: String, createdAt: Date = Date(), createdBy: String = currentUser?.id ?? "") {
        self.id = id
        self.createdByUser = createdBy
        self.createdAt = createdAt
        self.caption = caption
    }
}

