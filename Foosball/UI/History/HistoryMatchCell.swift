//
//  HistoryMatchCell.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import UIKit

final class HistoryMatchCell: UITableViewCell {

    @IBOutlet private weak var leftPlayerview: PlayerView!
    @IBOutlet private weak var leftPlayerResultLabel: UILabel!

    @IBOutlet private weak var rightPlayerview: PlayerView!
    @IBOutlet private weak var rightPlayerResultLabel: UILabel!

    @IBOutlet private weak var dateLabel: UILabel!

    func update(_ viewModel: MatchViewModel) {
        leftPlayerview.update(viewModel.firstPlayer)
        rightPlayerview.update(viewModel.secondPlayer)

        leftPlayerResultLabel.text = "\(viewModel.result.firstPlayerGoals)"
        leftPlayerResultLabel.textColor = viewModel.firstPlayerColor

        rightPlayerResultLabel.text = "\(viewModel.result.secondPlayerGoals)"
        rightPlayerResultLabel.textColor = viewModel.secondPlayerColor

        dateLabel.text = viewModel.date
    }
}
