//
//  LeaderBoardViewModel.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import Foundation

struct LeaderBoardViewModel {

    var playerStats: [PlayerStatsViewModel]

    init(_ provider: GameDataProvider, sortWith: (PlayerStatsViewModel, PlayerStatsViewModel) throws -> Bool) {
        playerStats = provider.stats().map { stats in
            PlayerStatsViewModel(
                player: stats.player,
                score: stats.score,
                matchesCount: stats.totalMatches,
                goalsCount: stats.totalGoals
            )
        }
        try? playerStats.sort(by: sortWith)
        playerStats.first?.isLeader = true
    }

}
