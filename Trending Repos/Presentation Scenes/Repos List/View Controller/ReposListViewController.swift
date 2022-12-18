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
    }
    
    private func registerCells() {
        tableView.register(
            cellType: ReposListLoadingCell.self,
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
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .idle:
            return UITableViewCell()
        case .loading:
            let cell = tableView.dequeueReusableCell(withType: ReposListLoadingCell.self, for: indexPath)
            return cell
        }
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
    }
}
