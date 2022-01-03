//
//  APIClient.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import Foundation
import Combine
import KituraContracts

enum APIError: Error {
    case URLProcessingFailed
    case requestFailed(Int)
    case postProcessingFailed(Error?)
}

struct APIClient {
    let session: URLSession
    let environment: APIEnvironment
    
    init(session: URLSession = .shared, environment: APIEnvironment = .prod) {
        self.session = session
        self.environment = environment
    }
    
    func publisherForRequest<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error> {
        var url = environment.baseURL.appendingPathComponent(request.path)
        var urlRequest : URLRequest
        if let params = request.params {
            let failureResult: Fail<T.Response, Error> = Fail(error: APIError.URLProcessingFailed)
            guard let queryItems: [URLQueryItem] = try? QueryEncoder().encode(params),
                  var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                      return failureResult.eraseToAnyPublisher()
                  }
            
            components.queryItems = queryItems
            guard let newUrl = components.url else {
                return failureResult.eraseToAnyPublisher()
            }
            url = newUrl
        }
        urlRequest = URLRequest(url: url)
        urlRequest.addValue(request.contentType, forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        let publisher = session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                    throw APIError.requestFailed(statusCode)
                }
                return data
            }
            .tryMap { data -> T.Response in
                try request.handle(response: data)
            }
            .tryCatch { error -> AnyPublisher<T.Response, APIError> in
                if error is APIError {
                  throw error
                } else {
                  throw APIError.postProcessingFailed(error)
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
        return publisher
    }
}
