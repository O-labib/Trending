//
//  ReposListInteractorTests.swift
//  Trending ReposTests
//
//  Created by Omar Labib on 19/12/2022.
//

import XCTest
@testable import Trending_Repos

final class ReposListInteractorTests: XCTestCase {
    var interactor: ReposListInteractor!
    var interactorClient: FakeInteractorClient!
    var remoteRepositoryStub: ReposListRemoteRepositoryStub!
    var localRepositoryStub: ReposListLocalRepositoryStub!
    
    override func setUpWithError() throws {
        remoteRepositoryStub = .init()
        localRepositoryStub = .init()
        interactor = .init(remoteRepository: remoteRepositoryStub, localRepository: localRepositoryStub)
        interactorClient = .init(interactor: interactor)
    }

    override func tearDownWithError() throws {
        remoteRepositoryStub = nil
        localRepositoryStub = nil
        interactor = nil
        interactorClient = nil
    }
}

extension ReposListInteractorTests {
    func testFetchRemoteRepos_WhenSuccess() {
        // Given
        let repos: [Repo] = [.stubbed()]
        remoteRepositoryStub.remoteReposResponse = .success(.init(repos: repos))

        // When
        interactorClient.fetchRemoteRepos()
        
        // Then
        guard case .success(repos) = interactorClient.remoteReposResponse else {
            return XCTFail()
        }
    }
    
    func testFetchRemoteRepos_WhenFailure() {
        // Given
        let error = NetworkError.unknown
        remoteRepositoryStub.remoteReposResponse = .failure(error)

        // When
        interactorClient.fetchRemoteRepos()
        
        // Then
        guard case .failure(NetworkError.unknown) = interactorClient.remoteReposResponse else {
            return XCTFail()
        }
    }
}
extension ReposListInteractorTests {
    class FakeInteractorClient {
        let interactor: ReposListInteractor
        
        init(interactor: ReposListInteractor) {
            self.interactor = interactor
        }
        var remoteReposResponse: Result<[Repo], Error>!
        func fetchRemoteRepos() {
            interactor.fetchRemoteRepos { [weak self]  result in
                self?.remoteReposResponse = result
            }
        }
    }
    
    class ReposListRemoteRepositoryStub: ReposListRemoteRepository {
        var remoteReposResponse: Result<Response, NetworkError>!
        
        func fetchRemoteRepos(_ completion: (Result<Response, NetworkError>) -> Void) {
            completion(remoteReposResponse)
        }
    }
    
    class ReposListLocalRepositoryStub: ReposListLocalRepository {
    }
}
