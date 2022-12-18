//
//  ReposListViewControllerTests.swift
//  Trending ReposTests
//
//  Created by Omar Labib on 18/12/2022.
//

import XCTest
@testable import Trending_Repos

final class ReposListViewControllerTests: XCTestCase {
    var testViewController: ReposListViewController!
    
    override func setUpWithError() throws {
        testViewController = ReposListViewController()
        testViewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        testViewController = nil
    }
}

// MARK: - Cells Dequeuing
extension ReposListViewControllerTests {
    func testUpdateViewState_ShowShimmeringCells_WhenLoading() {
        // Given
        let numberOfLoadingCells = 5
        let viewState: ReposListViewController.State = .loading(count: numberOfLoadingCells)
        
        // When
        testViewController.updateViewState(viewState)
        
        // Then
        let tableView = testViewController.tableView!
        XCTAssertEqual(
            testViewController.tableView(tableView, numberOfRowsInSection: 0),
            numberOfLoadingCells
        )
        for i in 0..<numberOfLoadingCells {
            let indexPath = IndexPath(row: i, section: 0)
            XCTAssertTrue(
                testViewController.tableView(tableView, cellForRowAt: indexPath) is ReposListLoadingCell
            )
        }
    }
    
    func testUpdateViewState_ShowNetworkErrorCell_WhenFailed() {
        // Given
        let viewState: ReposListViewController.State = .failed
        
        // When
        testViewController.updateViewState(viewState)
        
        // Then
        let tableView = testViewController.tableView!
        XCTAssertEqual(
            testViewController.tableView(tableView, numberOfRowsInSection: 0),
            1
        )
        XCTAssertTrue(
            testViewController.tableView(tableView, cellForRowAt: .init(row: 0, section: 0)) is ReposListFailureCell
        )
    }
    
    func testUpdateViewState_ShowNetworkErrorCell_WhenLoaded() {
        // Given
        let viewModel: [ReposListCell.ViewModel] = [
            .init(repoTitle: "1"),
            .init(repoTitle: "2")
        ]
        let viewState: ReposListViewController.State = .loaded(viewModel: viewModel)
        
        // When
        testViewController.updateViewState(viewState)
        
        // Then
        let tableView = testViewController.tableView!
        XCTAssertEqual(
            testViewController.tableView(tableView, numberOfRowsInSection: 0),
            viewModel.count
        )
        
        for i in 0..<viewModel.count {
            let indexPath = IndexPath(row: i, section: 0)
            
            guard let repoListCell = testViewController.tableView(tableView, cellForRowAt: indexPath) as? ReposListCell else {
                return XCTFail("Failed to dequeue repo cell")
            }
            
            XCTAssertEqual(
                repoListCell.viewModel,
                viewModel[i]
            )
        }
    }
}
