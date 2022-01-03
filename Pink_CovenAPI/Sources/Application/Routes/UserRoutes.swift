//
//  UserRoutes.swift
//  Application
//
//  Created by Lam Nguyen on 1/3/22.
//

import Foundation
import Kitura

var users: [UserAuthentication] = []

func initializeUserRoutes(app: App) {
    app.router.get("/api/v1/user", handler: getUser)
    app.router.post("/api/v1/user", handler: addUser)
    
}

func addUser(user: UserAuthentication, completion: @escaping (UserAuthentication?, RequestError?) -> Void) {
    users.append(user)
    completion(user, nil)
}

func getUser(query: UserParams, completion: @escaping (UserAuthentication?, RequestError?) -> Void) {
    guard let foundUser = users.first(where: { $0.id == query.id }), foundUser.password == query.password else {
        completion(nil, RequestError.unauthorized)
        return
    }
    completion(foundUser, nil)
}


