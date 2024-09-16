//
//  URLRequest+Resource.swift
//
//
//  Created on 19/3/24.
//

import Foundation

extension URLRequest {
    init<T>(resource: RemoteResource<T>) {
        var urlComponents = URLComponents(
            url: resource.url,
            resolvingAgainstBaseURL: true
        )!
        urlComponents.queryItems = resource.parameters?.map(URLQueryItem.init)
        let url = urlComponents.url!
        var request = URLRequest(
            url: url,
            cachePolicy: CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval: resource.requestTimeOut
        )
        resource.httpHeaders?.forEach { eachField in
            request.setValue(
                eachField.value,
                forHTTPHeaderField: eachField.key
            )
        }
        self = request
    }
}
