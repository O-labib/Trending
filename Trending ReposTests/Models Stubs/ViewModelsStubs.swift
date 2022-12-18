//
//  ViewModelsStubs.swift
//  Trending ReposTests
//
//  Created by Omar Labib on 18/12/2022.
//

import Foundation
@testable import Trending_Repos

extension ReposListCell.ViewModel {
    static func stubbed(title: String = "title") -> Self {
        .init(repoTitle: title)
    }
}
