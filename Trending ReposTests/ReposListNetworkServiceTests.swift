//
//  ReposListNetworkServiceTests.swift
//  Trending ReposTests
//
//  Created by Omar Labib on 19/12/2022.
//

import XCTest
@testable import Trending_Repos

final class ReposListNetworkServiceTests: XCTestCase {
    var networkService: ReposListNetworkService!
    var clientSpy: RemoteStorageClientSpy!

    override func setUpWithError() throws {
        clientSpy = .init()
        networkService = .init(networkClient: clientSpy)
    }

    override func tearDownWithError() throws {
        networkService = nil
        clientSpy = nil
    }

    func testURLRequestPassedSuccessfully() {
        // Given
        let urlRequest = try! EndPoints.trendingRepos.asURLRequest()

        // When
        networkService.fetchRemoteRepos { _ in }

        // Then
        XCTAssertEqual(
            clientSpy.request?.url,
            urlRequest.url
        )
    }
}

extension ReposListNetworkServiceTests {
    class RemoteStorageClientSpy: NetworkClient {
        var request: URLRequest?
        func perform<T>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
            self.request = request
        }
    }
}
