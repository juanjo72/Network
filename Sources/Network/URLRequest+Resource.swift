//
//  File.swift
//  
//
//  Created by Juanjo García Villaescusa on 19/3/24.
//

import Foundation

extension URLRequest {
    init<T>(resource: RemoteResource<T>) {
        var urlComponents = URLComponents(
            url: resource.url,
            resolvingAgainstBaseURL: true
        )!
        urlComponents.queryItems = resource.parameters?.map(Foundation.URLQueryItem.init)
        let url = urlComponents.url!
        var request = URLRequest(
            url: url,
            cachePolicy: CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval: resource.requestTimeOut
        )
        request.httpMethod = resource.httpMethod.rawValue
        resource.httpHeaders?.forEach { header in
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        self = request
    }
}
