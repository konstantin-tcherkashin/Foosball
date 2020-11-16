//
//  LeaderBoardPlayerCell.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import UIKit

final class LeaderBoardPlayerCell: UITableViewCell {

    @IBOutlet private weak var playerView: PlayerView!
    @IBOutlet private weak var crown: UIImageView!

    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var gamesCountLabel: UILabel!
    @IBOutlet private weak var goalsCountLabel: UILabel!

    func update(_ viewModel: PlayerStatsViewModel) {
        playerView.update(viewModel.player)
        crown.isHidden = !viewModel.isLeader

        scoreLabel.text = "\(Int(viewModel.score*100))% of wins"
        gamesCountLabel.text = "\(viewModel.matchesCount) games played"
        goalsCountLabel.text = "\(viewModel.goalsCount) goals"
    }

}
