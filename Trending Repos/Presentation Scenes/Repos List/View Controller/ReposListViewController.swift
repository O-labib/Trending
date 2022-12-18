//
//  ReposListViewController.swift
//  Trending Repos
//
//  Created by Omar Labib on 18/12/2022.
//

import UIKit

class ReposListViewController: UITableViewController {
    var presenter: ReposListPresenterProtocol!
    var state = State.idle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        
        presenter.loadAvailableRepos()
    }
    
    private func registerCells() {
        tableView.register(
            cellType: ReposListLoadingCell.self,
            ReposListFailureCell.self,
            ReposListCell.self
        )
    }
}

extension ReposListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .idle:
            return 0
        case .loading(let count):
            return count
        case .failed:
            return 1
        case .loaded(let viewModel):
            return viewModel.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .idle:
            return UITableViewCell()
        case .loading:
            let cell = tableView.dequeueReusableCell(withType: ReposListLoadingCell.self, for: indexPath)
            return cell
        case .failed:
            let cell = tableView.dequeueReusableCell(withType: ReposListFailureCell.self, for: indexPath)
            return cell
        case .loaded(let viewModel):
            let cell = tableView.dequeueReusableCell(withType: ReposListCell.self, for: indexPath)
            cell.viewModel = viewModel[indexPath.row]
            return cell
        }
    }
}

extension ReposListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case .loaded(var viewModel) = state else {
            return
        }
        viewModel[indexPath.row].isExpanded.toggle()
        self.state = .loaded(viewModel: viewModel)
    }
}

extension ReposListViewController: ReposListViewProtocol {
    func updateViewState(_ state: State) {
        self.state = state
        tableView.reloadData()
    }
}

extension ReposListViewController {
    enum State {
        case idle
        case loading(count: Int)
        case failed
        case loaded(viewModel: [ReposListCell.ViewModel])
    }
}
