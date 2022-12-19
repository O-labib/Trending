//
//  EndPoints.swift
//  Trending Repos
//
//  Created by Omar Labib on 19/12/2022.
//

import Foundation

enum EndPoints {
    case trendingRepos
    
    var pathComponents: [String] {
        switch self {
        case .trendingRepos:
            return ["search", "repositories"]
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .trendingRepos:
            return [
                URLQueryItem(name: "q", value: "language=+sort:stars")
            ]
        }
    }
    
    var fullUrl: String {
        NetworkConstants.url + "/" + pathComponents.joined(separator: "/")
    }
}

extension EndPoints {
    func asURLRequest() throws -> URLRequest {
        guard var urlComponents = URLComponents(
            string: fullUrl
        ) else {
            throw NetworkError.invalidURL
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        return URLRequest(url: url)
    }
}
