//
//  APIRequest.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import Foundation
import KituraContracts

enum HTTPMethod: String {
  case GET
  case POST
  case PUT
}

struct EmptyParams: QueryParams { }

protocol APIRequest {
  associatedtype Response
  associatedtype QueryParamsType: QueryParams

  var method: HTTPMethod { get }
  var path: String { get }
  var contentType: String { get }
  var body: Data? { get }
  var params: QueryParamsType? { get }

  func handle(response: Data) throws -> Response
}
