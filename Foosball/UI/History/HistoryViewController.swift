//
//  HistoryViewController.swift
//  Foosball
//
//  Created by Константин on 11.11.2020.
//

import UIKit

final class HistoryViewController: UIViewController {

    private var historyView: HistoryViewProtocol {
        view as! HistoryViewProtocol
    }

    let dataProvider: GameDataProvider = ServiceLocator.shared.gameDataProvider

    private lazy var dateFormatter: DateFormatter = {
        let instance = DateFormatter()
        instance.dateStyle = .short
        instance.timeStyle = .short
        return instance
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        historyView.viewModel = .init(dataProvider, dateFormatter: dateFormatter)
    }
}

extension HistoryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
