//
//  Entities.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

struct Response: Equatable, Decodable {
    let repos: [Repo]

    enum CodingKeys: String, CodingKey {
        case repos = "items"
    }
}

struct Repo: Equatable, Codable {
    let owner: Owner?
    let name: String?
    let description: String?
    let language: String?
    let stargazersCount: Int?

    struct Owner: Equatable, Codable {
        let name: String?
        let avatarUrl: String?

        enum CodingKeys: String, CodingKey {
            case name = "login"
            case avatarUrl
        }
    }
}

enum NetworkError: Error, Equatable {
    case unknown, invalidStatusCode, invalidURL
}
