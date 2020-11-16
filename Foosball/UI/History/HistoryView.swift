//
//  HistoryView.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import UIKit

protocol HistoryViewProtocol where Self: UIView {
    var viewModel: HistoryViewModel! { get set }
}

final class HistoryView: UIView, HistoryViewProtocol {

    @IBOutlet private weak var tableView: UITableView!

    var viewModel: HistoryViewModel! {
        didSet {
            tableView?.reloadData()
        }
    }

}

extension HistoryView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.matches.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryMatchCell
        cell.update(viewModel.matches[indexPath.row])
        return cell
    }
}
