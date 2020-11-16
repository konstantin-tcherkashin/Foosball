//
//  MatchViewModel.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import UIKit

struct MatchViewModel {

    var firstPlayer: PlayerViewModel
    var secondPlayer: PlayerViewModel
    var firstPlayerColor: UIColor
    var secondPlayerColor: UIColor
    var result: Match.Result
    var date: String?
    var actionTitle: String
    var actionColor: UIColor

    init(_ match: Match, dateFormatter: DateFormatter) {

        firstPlayer = .init(match.firstPlayer)
        secondPlayer = .init(match.secondPlayer)

        switch match.winner() {
        case .none:
            firstPlayerColor = .lightGray
            secondPlayerColor = .lightGray
        case match.firstPlayer:
            firstPlayerColor = .systemGreen
            secondPlayerColor = .systemRed
        default:
            firstPlayerColor = .systemRed
            secondPlayerColor = .systemGreen
        }

        result = match.result
        if let start = match.startDate, let end = match.endDate {
            date = [
                dateFormatter.string(from: start),
                dateFormatter.string(from: end)
            ].joined(separator: " - ")
        }

        switch match.state {
        case .configuring:
            actionTitle = "Start"
            actionColor = .systemGreen
        case .started:
            actionTitle = "Finish"
            actionColor = .systemRed
        case .finished:
            actionTitle = "New match"
            actionColor = .systemYellow
        }
    }

}
