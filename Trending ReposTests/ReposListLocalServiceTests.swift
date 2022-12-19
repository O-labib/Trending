//
//  LocalStorageClientTests.swift
//  Trending ReposTests
//
//  Created by Omar Labib on 19/12/2022.
//

import XCTest
@testable import Trending_Repos

final class ReposListLocalServiceTests: XCTestCase {
    var localService: ReposListLocalService!
    var clientSpy: LocalStorageClientSpy<[Repo]>!
    
    override func setUpWithError() throws {
        clientSpy = .init()
        localService = .init(localClient: clientSpy)
    }

    override func tearDownWithError() throws {
        localService = nil
        clientSpy = nil
    }
}

extension ReposListLocalServiceTests {
    func testStoreRepos_SaveThemLocally() {
        // Given
        let repos = [Repo.stubbed()]
        
        // When
        localService.storeRepos(repos)
        
        // Then
        XCTAssertEqual(
            localService.localRepos(),
            repos
        )
    }
}

extension ReposListLocalServiceTests {
    class LocalStorageClientSpy<D: Codable>: LocalStorageClient {
        private var storage: D!
        
        func store<T>(_ value: T) throws where T : Encodable {
            self.storage = value as? D
        }
        
        func fetch<T>() throws -> T where T : Decodable {
            storage as! T
        }
    }
}
