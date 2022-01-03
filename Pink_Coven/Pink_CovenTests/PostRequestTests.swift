//
//  PostRequestTests.swift
//  Pink_CovenTests
//
//  Created by M_2022814 on 1/1/22.
//

import XCTest
@testable import Pink_Coven

class PostRequestTests: XCTestCase {

    func testHandleWithGoodData() throws {
        let data = JsonData.goodPosts.data(using: .utf8)!
        
        let request = PostRequest()
        do {
            let result = try request.handle(response: data)
            XCTAssertEqual(result.count, 3)
        } catch let decodingError as DecodingError {
            XCTFail((decodingError as CustomDebugStringConvertible).debugDescription)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testHandleWithBadData() throws {
        let data = JsonData.badPosts.data(using: .utf8)!
        
        let request = PostRequest()
        XCTAssertThrowsError(try request.handle(response: data)) {
            error in
            XCTAssertTrue(error is DecodingError)
        }
    }
}
