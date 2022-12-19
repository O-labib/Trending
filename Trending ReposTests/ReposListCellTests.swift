//
//  ReposListTests.swift
//  Trending ReposTests
//
//  Created by Omar Labib on 18/12/2022.
//

import XCTest
@testable import Trending_Repos

final class ReposListCellTests: XCTestCase {
    var cell: ReposListCell!

    override func setUpWithError() throws {
        cell = Bundle.main.loadNibNamed("ReposListCell", owner: nil, options: nil)?.first as? ReposListCell
    }

    override func tearDownWithError() throws {
        cell = nil
    }

    func testConfigureCellWithViewModel() {
        // Given
        let viewModel = ReposListCell.ViewModel.stubbed()
        
        // When
        cell.viewModel = viewModel
        
        // Then
        let expectationsPairs: [(String?, String?)] = [
            (cell.ownerNameLabel.text, viewModel.ownerName),
            (cell.repoTitleLabel.text, viewModel.repoTitle),
            (cell.repoDescriptionLabel.text, viewModel.repoDescription),
            (cell.languageLabel.text, viewModel.repoLanguage),
            (cell.starsLabel.text, viewModel.repoStart),
        ]
        expectationsPairs.forEach { actualResult, expectedResult in
            XCTAssertEqual(
                actualResult,
                expectedResult
            )
        }
    }
    
    func testExpandCollapseBehavior() {
        // Given
        let viewModels: [ReposListCell.ViewModel] = [
            .stubbed(isExpanded: true),
            .stubbed(isExpanded: false)
        ]
        
        for viewModel in viewModels {
            // When
            cell.viewModel = viewModel
            
            // Then
            XCTAssertEqual(
                cell.detailStackView.isHidden,
                !viewModel.isExpanded
            )
        }
    }
}
