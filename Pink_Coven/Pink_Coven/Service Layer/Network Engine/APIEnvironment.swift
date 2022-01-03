//
//  APIEnvironment.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import Foundation

struct APIEnvironment {
    var baseURL: URL
}

extension APIEnvironment {
    static let prod = APIEnvironment(baseURL: URL(string: "http://192.168.1.172:8080/api/v1")!)
    static let local = APIEnvironment(baseURL: URL(string: "http://localhost:8080/api/v1")!)
    static let local81 = APIEnvironment(baseURL: URL(string: "http://localhost:8081/api/v1")!)
}

