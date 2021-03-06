//
//  ApiClientTests.swift
//  Pink_CovenTests
//
//  Created by M_2022814 on 1/1/22.
//

import XCTest
import Swifter
import Combine
@testable import Pink_Coven

class ApiClientTests: XCTestCase {

    var server = HttpServer()
        
        override func setUpWithError() throws {
            // Put setup code here. This method is called before the invocation of each test method in the class.
            server.notFoundHandler = {
                        [weak self] request in
                    let attachment = XCTAttachment(string: "\(request.method) on \(request.path) requested, but not found")
                    attachment.name = "Unhandled API path requested"
                    attachment.lifetime = .keepAlways
                    self?.add(attachment)
                return .notFound()
            }
            do {
                try server.start()
            } catch {
                XCTFail("Could Not Start Swifter")
            }
        }
        
        override func tearDownWithError() throws {
            server.stop()
        }
          
        // This test fails on my macbook because of the security controls the organization has implemented on this my macbook.
        func testPublisherForRequest() {
            server.GET["/api/v1/posts"] = { _ in HttpResponse.ok(.text(JsonData.goodPosts))}
            
            let request = GetAllPostRequest()
            let client = APIClient(environment: .local)
            
            var networkResult: Subscribers.Completion<Error>?
            var fetchedPosts: [Post]?
            let networkExpectation = expectation(description: "Network request")
            
            let cancellable = client.publisherForRequest(request)
                .sink { result in
                    networkResult = result
                    XCTAssertTrue(Thread.current.isMainThread, "Network completion called on background thread")
                    networkExpectation.fulfill()
                } receiveValue: { posts in
                    fetchedPosts = posts
                }
            
            wait(for: [networkExpectation], timeout: 3)
            cancellable.cancel()
            
            guard let result = networkResult else {
                XCTFail("No result from network request")
                return
            }
            switch result {
            case .finished:
                XCTAssertEqual(fetchedPosts?.count ?? 0, 3)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    
}
