//
//  ReposListSceneConfigurator.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation

enum ReposListSceneConfigurator {
    static func configured() -> ReposListViewController {
        let remoteRepository = ReposListNetworkService(
            networkClient: ClientsConfigurator.configuredNetworkClient()
        )
        let localRepository = ReposListLocalService(
            localClient: ClientsConfigurator.configuredLocalStorageClient()
        )
        let useCase = ReposListInteractor(
            remoteRepository: remoteRepository,
            localRepository: localRepository
        )
        let viewController = ReposListViewController()
        let presenter = ReposListPresenter(
            view: viewController,
            reposListUseCase: useCase
        )
        viewController.presenter = presenter
        return viewController
    }
}
