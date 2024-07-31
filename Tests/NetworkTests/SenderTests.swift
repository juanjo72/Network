//
//  File.swift
//  
//
//  Created by Juanjo García Villaescusa on 1/4/24.
//

@testable import Network
import XCTest

final class SenderTests: XCTestCase {
    typealias SenderType = (URLRequest) async throws -> (Data, URLResponse)
    
    // MARK: SUT
    
    func makeSUT(
        sender: @escaping SenderType = { _ in (Data(), URLResponse()) }
    ) -> Network.RequestSender {
        Network.RequestSender(
            sender: sender
        )
    }
    
    // MARK: request
    
    func testThat_WhenRequest_ThenResponseMatchesDecodedValue() async throws {
        // When
        let expectedResult = "A string"
        let resource = RemoteResource<String>(
            url: URL(string: "http://www.subdomain.com")!,
            decoder: { _ in
                expectedResult
            }
        )
        let sut = self.makeSUT()
        
        // When
        let response = try await sut.request(resource: resource)
        
        // Then
        XCTAssertEqual(response, expectedResult)
    }
    
    func testThat_WhenRequest_() async throws {
        // When
        var sendRequest: URLRequest?
        let sender: SenderType = {
            sendRequest = $0
            return (Data(), URLResponse())
        }
        let expectedResult = "A string"
        let resource = RemoteResource<String>(
            url: URL(string: "http://www.subdomain.com")!,
            decoder: { _ in
                expectedResult
            }
        )
        let request = URLRequest(resource: resource)
        let sut = self.makeSUT(
            sender: sender
        )
        
        // When
        _ = try await sut.request(resource: resource)
        
        // Then
        XCTAssertEqual(request, sendRequest)
    }
}
