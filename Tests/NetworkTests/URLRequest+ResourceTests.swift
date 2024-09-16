//
//  URLRequest+ResourceTests.swift
//
//
//  Created on 1/4/24.
//

import Foundation
@testable import Network
import XCTest

final class URLRequestResourceTests: XCTestCase {
    func test_GivenResource_WhenRequestIsCreated_ThenURLIsCorrect() throws {
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

        // Then
        let requestUrl = try XCTUnwrap(resourceRequest.url)
        let components = try XCTUnwrap(URLComponents(string: requestUrl.absoluteString))
        let componentsHost = try XCTUnwrap(components.host)
        XCTAssertEqual(componentsHost, "www.subdomain.com")
    }
    
    func test_GivenResource_WhenRequestIsCreated_ThenParametersAreCorrect() throws {
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

        // Then
        let requestUrl = try XCTUnwrap(resourceRequest.url)
        let components = try XCTUnwrap(URLComponents(string: requestUrl.absoluteString))
        let names = try XCTUnwrap(components.queryItems?.map(\.name).sorted(by: <))
        let values = try XCTUnwrap(components.queryItems?.compactMap(\.value).sorted(by: <))
        XCTAssertEqual(names, ["limit", "name"])
        XCTAssertEqual(values, ["10", "Spiderman"])
    }
    
    func test_GivenResource_WhenRequestIsCreated_ThenTimeOutIsCorrect() throws {
        // Given
        let resource = RemoteResource<String>(
            url: URL(string: "http://www.subdomain.com")!,
            requestTimeOut: 5
        )
        
        // When
        let resourceRequest = URLRequest(resource: resource)

        // Then
        XCTAssertEqual(resourceRequest.timeoutInterval, 5)
    }
    
    func testThat_WhenTypeIsDecodable_ThenDefaultDecodableIsJSONDecodable() throws {
        // Given
        let JSON = """
        {
            "id": "550e8400-e29b-41d4-a716-446655440000",
            "name": "John"
        }
        """
        let data = JSON.data(using: .utf8)!
        
        // When
        let resource = RemoteResource<User>(
            url: URL(string: "http://www.subdomain.com")!
        )
        
        // Then
        let user = try resource.decoder(data)
        let expected = User(
            id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440000")!,
            name: "John"
        )
        XCTAssertEqual(user, expected)
    }
}

struct User: Decodable, Equatable {
    let id: UUID
    let name: String
}
