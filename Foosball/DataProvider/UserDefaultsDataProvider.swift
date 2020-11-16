//
//  UserDefaultsDataProvider.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import Foundation

final class UserDefaultsDataProvider: GameDataProvider {

    func matches() -> [Match] {
        UserDefaultsStorage.get(for: .matches) ?? []
    }

    func players() -> [Player] {
        UserDefaultsStorage.get(for: .players) ?? []
    }

    func stats() -> [PlayerStats] {
        var result = [PlayerStats]()

        let matches = self.matches()

        for player in players() {

            let allMatches = matches.filter({
                $0.firstPlayer == player || $0.secondPlayer == player
            })

            let stats = PlayerStats(
                player: player,
                totalMatches: allMatches.count,
                totalWins: allMatches.filter({ $0.winner() == player }).count,
                totalGoals: allMatches.map({
                    $0.winner() == player ? $0.result.max : $0.result.min
                }).reduce(0, { $0 + $1 })
            )

            result.append(stats)
        }
        return result
    }

    func add(match: Match) {
        UserDefaultsStorage.set(matches() + [match], for: .matches)
    }

    func add(player: Player) {
        let players = self.players()
        guard !players.contains(player) else { return }

        UserDefaultsStorage.set(players + [player], for: .players)
    }

}
