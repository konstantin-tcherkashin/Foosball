//
//  Match.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import Foundation

final class Match: Codable {

    init(
        firstPlayer: Player? = nil,
        secondPlayer: Player? = nil,
        result: Result = .init(0, 0)
    ) {
        self.firstPlayer = firstPlayer
        self.secondPlayer = secondPlayer
        self.result = result
    }

    typealias Result = MatchResult

    var firstPlayer: Player?
    var secondPlayer: Player?

    var result: Result
    var startDate: Date?
    var endDate: Date?

    enum States: String, Codable {
        case configuring, started, finished
    }

    var state: States = .configuring {
        didSet {
            switch state {
            case .started:
                startDate = Date()
            case .finished:
                endDate = Date()
            default:
                break
            }
        }
    }

}

extension Match {

    func goals(for player: Player) -> Int {
        if firstPlayer == player {
            return result.firstPlayerGoals
        } else if secondPlayer == player {
            return result.secondPlayerGoals
        } else {
            assertionFailure()
            return 0
        }
    }

    func winner() -> Player? {
        if result.firstPlayerGoals == result.secondPlayerGoals {
            return nil
        } else if result.firstPlayerGoals > result.secondPlayerGoals {
            return firstPlayer
        } else {
            return secondPlayer
        }
    }

}
