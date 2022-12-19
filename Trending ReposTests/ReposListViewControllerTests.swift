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
    var presenterSpy: PresenterSpy!

    override func setUpWithError() throws {
        testViewController = ReposListViewController()
        presenterSpy = .init()
        testViewController.presenter = presenterSpy
        testViewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        presenterSpy = nil
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
            .stubbed(title: "1"),
            .stubbed(title: "2")
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

// MARK: - Test Cell Expand/Collapse
extension ReposListViewControllerTests {
    func testCellExpandAndCollapse_WhenTappingOnCell() {
        // Given
        let viewModel: [ReposListCell.ViewModel] = [
            .stubbed(isExpanded: false),
            .stubbed(isExpanded: true)
        ]
        testViewController.updateViewState(.loaded(viewModel: viewModel))

        // When
        for i in 0..<viewModel.count {
            let tableView = testViewController.tableView!
            let indexPath = IndexPath(row: i, section: 0)
            testViewController.tableView(tableView, didSelectRowAt: indexPath)
        }

        // Then
        guard case .loaded(let updatedViewModel) = testViewController.state else {
            return XCTFail()
        }
        for (old, updated) in zip(viewModel, updatedViewModel) {
            XCTAssertEqual(
                updated.isExpanded,
                !old.isExpanded
            )
        }
    }
}

// MARK: - Presenter Interaction
extension ReposListViewControllerTests {
    func testLoadAvailableRepos_IsCalled_WhenViewLoaded() {
        // Then
        XCTAssertEqual(
            presenterSpy.loadAvailableReposCallCount,
            1
        )
    }

    func testRefreshRepos_IsCalled_WhenTableViewPulled() {
        // When
        testViewController.refreshControl?.sendActions(for: .valueChanged)

        // Then
        XCTAssertEqual(
            presenterSpy.refreshReposCallCount,
            1
        )
    }

    func testReloadRepos_IsCalled_WhenTappingRetryOnFailureCell() {
        // When
        testViewController.updateViewState(.failed)

        // Then
        let tableView = testViewController.tableView!
        guard let failureCell = testViewController.tableView(tableView, cellForRowAt: .init(row: 0, section: 0)) as? ReposListFailureCell else {
            return XCTFail("Failed to dequeue repo cell")
        }
        failureCell.retryAction?()

        XCTAssertEqual(
            presenterSpy.reloadReposCallCount,
            1
        )
    }
}

// MARK: - Refresh Control Behavior
extension ReposListViewControllerTests {
    func testUpdateViewState_EndRefreshing() {
        // Given
        testViewController.refreshControl?.beginRefreshing()

        // When
        testViewController.updateViewState(.loaded(viewModel: []))

        // Then
        XCTAssertFalse(testViewController.refreshControl!.isRefreshing)
    }
}

// MARK: - Refresh Control Behavior
extension ReposListViewControllerTests {
    func testDidTapCell_ToggleCellExpansionState() {
        func reposCell(for index: IndexPath) -> ReposListCell {
            tableView.cellForRow(at: index) as! ReposListCell
        }

        // Given
        let tableView = testViewController.tableView!
        let viewModel: [ReposListCell.ViewModel] = [
            .stubbed(isExpanded: false),
            .stubbed(isExpanded: true)
        ]
        testViewController.updateViewState(.loaded(viewModel: viewModel))

        let indices = viewModel.enumerated()
            .map({ IndexPath(row: $0.offset, section: 0) })

        for indexPath in indices {
            let isInitiallyCollapsed = reposCell(for: indexPath).detailStackView.isHidden

            // When
            testViewController.tableView(tableView, didSelectRowAt: indexPath)
            let isCollapsedAfterTap = reposCell(for: indexPath).detailStackView.isHidden

            // Then
            XCTAssertNotEqual(isInitiallyCollapsed, isCollapsedAfterTap)
        }
    }
}

extension ReposListViewControllerTests {
    class PresenterSpy: ReposListPresenterProtocol {
        var loadAvailableReposCallCount = 0
        var refreshReposCallCount = 0
        var reloadReposCallCount = 0

        func loadAvailableRepos() {
            loadAvailableReposCallCount += 1
        }

        func refreshRepos() {
            refreshReposCallCount += 1
        }

        func reloadRepos() {
            reloadReposCallCount += 1
        }
    }
}
