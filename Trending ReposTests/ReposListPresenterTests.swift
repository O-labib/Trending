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
extension ReposListPresenterTests {
    class ViewControllerSpy: ReposListViewProtocol {
        func updateViewState(_ state: Trending_Repos.ReposListViewController.State) {
        }
    }
    
    class ReposListUseCaseStub: ReposListUseCase {
        
    }
}
