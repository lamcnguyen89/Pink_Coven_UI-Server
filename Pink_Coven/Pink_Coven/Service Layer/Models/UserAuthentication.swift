//
//  UserAuthentication.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import Foundation

var currentUser: UserAuthentication?

struct UserAuthentication: Codable {
    var id: String
    var email: String?
    var password: String?
}

