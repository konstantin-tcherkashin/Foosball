//
//  PlayerStatsViewModel.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import Foundation

final class PlayerStatsViewModel {

    internal init(player: PlayerViewModel, score: Double, matchesCount: Int, goalsCount: Int, isLeader: Bool = false) {
        self.player = player
        self.score = score
        self.matchesCount = matchesCount
        self.goalsCount = goalsCount
        self.isLeader = isLeader
    }

    var player: PlayerViewModel
    var score: Double
    var matchesCount: Int
    var goalsCount: Int
    var isLeader: Bool = false

}
