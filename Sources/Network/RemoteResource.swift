// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public struct RemoteResource<T> {
    public var url: Foundation.URL
    public var httpMethod: RequestMethod
    public var httpHeaders: [String: String]?
    public var parameters: [String: String]?
    public var requestTimeOut: TimeInterval
    public var decoder: (Data) throws -> T
    
    public init(
        url: URL,
        httpMethod: RequestMethod = .get,
        httpHeaders: [String: String]? = nil,
        parameters: [String: String]? = nil,
        requestTimeOut: TimeInterval = 5,
        decoder: @escaping (Data) throws -> T
    ) {
        self.url = url
        self.httpMethod = httpMethod
        self.httpHeaders = httpHeaders
        self.parameters = parameters
        self.requestTimeOut = requestTimeOut
        self.decoder = decoder
    }
}
