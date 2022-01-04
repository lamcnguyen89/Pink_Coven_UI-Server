//
//  UserRoutes.swift
//  Application
//
//  Created by Lam Nguyen on 1/3/22.
//

import Foundation
import Kitura



func initializeUserRoutes(app: App) {
    app.router.get("/api/v1/user", handler: getUser)
    app.router.post("/api/v1/user", handler: addUser)
    
}

func addUser(user: UserAuthentication, completion: @escaping (UserAuthentication?, RequestError?) -> Void) {
    users.append(user)
    // We're passing the user back to the response, but we'll clear out the passed in password first
    var user = savedUser
    user?.password = ""
    completion(user, error)
}

func getUser(query: UserParams, completion: @escaping (UserAuthentication?, RequestError?) -> Void) {
    UserAuthentication.findAll(matching: query) { users, error in
        guard let user = users?.first else {
            completion(nil, error ?? .unauthorized)
            return
        }
        completion(user, nil)
    }
}


