//
//  LeaderboardViewController.swift
//  Foosball
//
//  Created by Константин on 11.11.2020.
//

import UIKit

extension LeaderboardViewController {

    enum SortModes: Int {
        case score, matches, goals
    }

}

final class LeaderboardViewController: UIViewController {

    var dataProvider: GameDataProvider = ServiceLocator.shared.gameDataProvider

    private var sortMode: SortModes = .score

    private var leaderBoardView: LeaderBoardViewProtocol {
        view as! LeaderBoardViewProtocol
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        updateViewModel()

    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        guard let mode = SortModes(rawValue: sender.selectedSegmentIndex) else { return }
        sortMode = mode
        updateViewModel()
    }

    private func updateViewModel() {
        leaderBoardView.viewModel = LeaderBoardViewModel(dataProvider, sortWith: { [weak self] in
            switch self?.sortMode {
            case .score:
                return $0.score > $1.score
            case .matches:
                if $0.matchesCount == $1.matchesCount {
                    return $0.score > $1.score
                }
                return $0.matchesCount > $1.matchesCount
            case .goals:
                if $0.goalsCount == $1.goalsCount {
                    return $0.score > $1.score
                }
                return $0.goalsCount > $1.goalsCount
            case .none:
                return true
            }
        })
    }

}

extension LeaderboardViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
