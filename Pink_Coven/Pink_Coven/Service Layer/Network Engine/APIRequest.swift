//
//  APIRequest.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    
}

protocol APIRequest {
    associatedtype Response
    
    var method: HTTPMethod { get }
    var path: String { get }
    var contentType: String { get }
    var body: Data? { get }
    
    func handle(response: Data) throws -> Response
}
