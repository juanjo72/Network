//
//  File.swift
//
//
//  Created by Juanjo García Villaescusa on 1/4/24.
//

import Foundation
@testable import Network
import XCTest

final class URLRequestResourceTests: XCTestCase {
    func test_GivenResource_WhenRequestIsCreated_ThenResultIsExpected() {
        // Given
        let resource = RemoteResource<String>(
            url: URL(string: "http://www.subdomain.com")!,
            parameters: [
                "name": "Spiderman",
                "limit": "10"
            ],
            decoder: { _ in
                "Hello world"
            }
        )
        
        // When
        let resourceRequest = URLRequest(resource: resource)
        let request =  URLRequest(
            url: URL(string: "http://www.subdomain.com?limit=10&name=Spiderman")!,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 5
        )
        // Then
        XCTAssertEqual(resourceRequest, request)
    }
}
