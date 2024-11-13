//
//  RemoteResource.swift
//
//
//  Created on 19/3/24.
//

import Foundation

public struct RemoteResource<T>: Sendable {
    let url: URL
    let httpHeaders: [String: String]?
    let parameters: [String: String]?
    let requestTimeOut: TimeInterval
    let decoder: @Sendable (Data) throws -> T

    public init(
        url: URL,
        httpHeaders: [String: String]? = nil,
        parameters: [String: String]? = nil,
        requestTimeOut: TimeInterval = 5,
        decoder: @escaping @Sendable (Data) throws -> T
    ) {
        self.url = url
        self.httpHeaders = httpHeaders
        self.parameters = parameters
        self.requestTimeOut = requestTimeOut
        self.decoder = decoder
    }
    
    public init(
        url: URL,
        httpHeaders: [String: String]? = nil,
        parameters: [String: String]? = nil,
        requestTimeOut: TimeInterval = 5
    ) where T: Decodable {
        self.url = url
        self.httpHeaders = httpHeaders
        self.parameters = parameters
        self.requestTimeOut = requestTimeOut

        self.decoder = {
            try JSONDecoder().decode(T.self, from: $0)
        }
    }
}
