//
//  PlayerMatchView.swift
//  Foosball
//
//  Created by Константин on 16.11.2020.
//

import UIKit

protocol PlayerMatchViewDelegate: AnyObject {

    func minusTapped(in matchView: PlayerMatchView)
    func plusTapped(in matchView: PlayerMatchView)
    func avatarTapped(in matchView: PlayerMatchView)

}

final class PlayerMatchView: UIView {

    @IBOutlet private weak var playerView: PlayerView!
    @IBOutlet private weak var goalsLabel: UILabel!

    weak var delegate: PlayerMatchViewDelegate?

    @IBAction func plusTapped() {
        delegate?.plusTapped(in: self)
    }

    @IBAction func minusTapped() {
        delegate?.minusTapped(in: self)
    }

    @IBAction func avatarTapped() {
        delegate?.avatarTapped(in: self)
    }

    func update(_ playerModel: PlayerViewModel, goals: Int, color: UIColor) {
        var model = playerModel
        if model.name == nil {
            model.name = "Select player"
        }
        playerView.update(model)
        goalsLabel.text = "\(goals)"
        goalsLabel.textColor = color
    }


}
