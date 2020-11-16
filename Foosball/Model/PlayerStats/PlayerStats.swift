//
//  PlayerStats.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import Foundation

final class PlayerStats {

    init(player: Player, totalMatches: Int, totalWins: Int, totalGoals: Int) {
        self.player = .init(player)
        self.totalMatches = totalMatches
        self.totalWins = totalWins
        self.totalGoals = totalGoals
    }

    var player: PlayerViewModel
    var totalMatches: Int
    private var totalWins: Int
    var totalGoals: Int

    lazy var score: Double = {
        guard totalMatches != 0 else { return 0 }
        return Double(totalWins)/Double(totalMatches)
    }()

}
