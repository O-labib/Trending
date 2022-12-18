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
    var remoteRepositoryStub: ReposListRemoteRepositoryStub!
    var localRepositoryStub: ReposListLocalRepositoryStub!
    
    override func setUpWithError() throws {
        remoteRepositoryStub = .init()
        localRepositoryStub = .init()
        interactor = .init(remoteRepository: remoteRepositoryStub, localRepository: localRepositoryStub)
    }

    override func tearDownWithError() throws {
        remoteRepositoryStub = nil
        localRepositoryStub = nil
        interactor = nil
    }
}

extension ReposListInteractorTests {
    class ReposListRemoteRepositoryStub: ReposListRemoteRepository {
    }
    
    class ReposListLocalRepositoryStub: ReposListLocalRepository {
    }
}
