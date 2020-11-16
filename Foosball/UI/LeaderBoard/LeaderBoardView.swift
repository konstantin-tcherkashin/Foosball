//
//  LeaderBoardView.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import UIKit

protocol LeaderBoardViewProtocol where Self: UIView {
    var viewModel: LeaderBoardViewModel! { get set }
}

final class LeaderBoardView: UIView, LeaderBoardViewProtocol {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView?.tableFooterView = UIView()
        }
    }

    var viewModel: LeaderBoardViewModel! {
        didSet {
            tableView?.reloadData()
        }
    }

}

extension LeaderBoardView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.playerStats.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaderBoardPlayerCell
        let statCellModel = viewModel.playerStats[indexPath.row]
        cell.update(statCellModel)
        return cell
    }

}
