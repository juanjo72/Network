//
//  RequestSender.swift
//
//
//  Created on 19/3/24.
//

import Foundation

public protocol RequestSenderProtocol: Sendable {
    func request<T>(resource: RemoteResource<T>) async throws -> T
}

public actor RequestSender: RequestSenderProtocol {
    private let sender: (URLRequest) async throws -> (Data, URLResponse)

    public static func shared() -> Self {
        self.init(sender: URLSession.shared.data)
    }
    
    init(
        sender: @escaping (URLRequest) async throws -> (Data, URLResponse)
    ) {
        self.sender = sender
    }
    
    public func request<T>(resource: RemoteResource<T>) async throws -> T {
        let request = URLRequest(resource: resource)
        let (data, _) = try await self.sender(request)
        return try resource.decoder(data)
    }
}
