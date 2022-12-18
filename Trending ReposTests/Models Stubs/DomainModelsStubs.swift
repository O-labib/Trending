//
//  DomainModelsStubs.swift
//  Trending ReposTests
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation
@testable import Trending_Repos

extension Repo {
    static func stubbed() -> Self {
        .init(
            owner: .init(
                name: "name",
                avatarUrl: "url"
            ),
            name: "repo name",
            description: "description",
            language: "language",
            stargazersCount: 10
        )
    }
}
