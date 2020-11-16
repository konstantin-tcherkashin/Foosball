//
//  MatchResult.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import Foundation

struct MatchResult: Codable {

    var firstPlayerGoals: Int
    var secondPlayerGoals: Int

    init(_ lhs: Int, _ rhs: Int) {
        firstPlayerGoals = lhs
        secondPlayerGoals = rhs
    }

    enum States {
        case firstWon, secondWon, draw
    }

    var state: States {
        if firstPlayerGoals == secondPlayerGoals {
            return .draw
        } else if firstPlayerGoals > secondPlayerGoals {
            return .firstWon
        } else {
            return .secondWon
        }
    }
}

extension Match.Result {

    var max: Int {
        return Swift.max(firstPlayerGoals, secondPlayerGoals)
    }

    var min: Int {
        return Swift.min(firstPlayerGoals, secondPlayerGoals)
    }

}
