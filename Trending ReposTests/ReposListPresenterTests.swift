//
//  ReposListPresenterTests.swift
//  Trending ReposTests
//
//  Created by Omar Labib on 18/12/2022.
//

import XCTest
@testable import Trending_Repos

final class ReposListPresenterTests: XCTestCase {
    var presenter: ReposListPresenter!
    var viewControllerSpy: ViewControllerSpy!
    var useCaseStub: ReposListUseCaseStub!
    
    override func setUpWithError() throws {
        viewControllerSpy = .init()
        useCaseStub = .init()
        presenter = .init(view: viewControllerSpy, reposListUseCase: useCaseStub)
    }

    override func tearDownWithError() throws {
        useCaseStub = nil
        viewControllerSpy = nil
        presenter = nil
    }

}

// MARK: - Available & Cached Repos Behavior
extension ReposListPresenterTests {
    func testLoadAvailableRepos_CallsUpdateViewState_WhenFailed() {
        // Given
        useCaseStub.availableReposResponse = .failure(NetworkError.unknown)
        
        // When
        presenter.loadAvailableRepos()
        
        // Then
        XCTAssertEqual(
            viewControllerSpy.updatedViewStates.first,
            .loading(count: 10)
        )
        XCTAssertEqual(
            viewControllerSpy.updatedViewStates.last,
            .failed
        )
    }
    
    func testLoadAvailableRepos_CallsUpdateViewState_WhenSuccess() {
        // Given
        let repos: [Repo] = [.stubbed()]
        useCaseStub.availableReposResponse = .success(repos)
        
        // When
        presenter.loadAvailableRepos()
        
        // Then
        let cellsViewModels: [ReposListCell.ViewModel] = repos.map(presenter.convert(_:))
        XCTAssertEqual(
            viewControllerSpy.updatedViewStates.first,
            .loading(count: 10)
        )
        XCTAssertEqual(
            viewControllerSpy.updatedViewStates.last,
            .loaded(viewModel: cellsViewModels)
        )
    }
}

// MARK: - Remote Repos Behavior
extension ReposListPresenterTests {
    func testRefreshRepos_CallsUpdateViewState_WhenFailed() {
        // Given
        useCaseStub.remoteReposResponse = .failure(NetworkError.unknown)
        
        // When
        presenter.refreshRepos()
        
        // Then
        XCTAssertEqual(
            viewControllerSpy.updatedViewStates.first,
            .loading(count: 10)
        )
        XCTAssertEqual(
            viewControllerSpy.updatedViewStates.last,
            .failed
        )
    }
    
    func testRefreshRepos_CallsUpdateViewState_WhenSuccess() {
        // Given
        let repos: [Repo] = [.stubbed()]
        useCaseStub.remoteReposResponse = .success(repos)
        
        // When
        presenter.refreshRepos()
        
        // Then
        let cellsViewModels: [ReposListCell.ViewModel] = repos.map(presenter.convert(_:))
        XCTAssertEqual(
            viewControllerSpy.updatedViewStates.first,
            .loading(count: 10)
        )
        XCTAssertEqual(
            viewControllerSpy.updatedViewStates.last,
            .loaded(viewModel: cellsViewModels)
        )
    }
}

extension ReposListPresenterTests {
    class ViewControllerSpy: ReposListViewProtocol {
        var updatedViewStates: [ReposListViewController.State] = []
        
        func updateViewState(_ state: Trending_Repos.ReposListViewController.State) {
            updatedViewStates.append(state)
        }
    }
    
    class ReposListUseCaseStub: ReposListUseCase {
        var availableReposResponse: Result<[Trending_Repos.Repo], Error>!
        func fetchAvailableRepos(_ completion: (Result<[Trending_Repos.Repo], Error>) -> Void) {
            completion(availableReposResponse)
        }
        
        var remoteReposResponse: Result<[Trending_Repos.Repo], Error>!
        func fetchRemoteRepos(_ completion: (Result<[Repo], Error>) -> Void) {
            completion(remoteReposResponse)
        }
    }
}
