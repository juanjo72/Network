//
//  RemoteResource.swift
//
//
//  Created on 19/3/24.
//

import Foundation

public struct RemoteResource<T> {
    let url: URL
    let httpHeaders: [String: String]?
    let parameters: [String: String]?
    let requestTimeOut: TimeInterval
    let decoder: (Data) throws -> T
    
    public init(
        url: URL,
        httpHeaders: [String: String]? = nil,
        parameters: [String: String]? = nil,
        requestTimeOut: TimeInterval = 5,
        decoder: @escaping (Data) throws -> T
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
