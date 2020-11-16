//
//  HistoryViewModel.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import Foundation

struct HistoryViewModel {
    
    var matches: [MatchViewModel]

    init(_ dataProvider: GameDataProvider, dateFormatter: DateFormatter) {
        matches = dataProvider.matches().map({ .init($0, dateFormatter: dateFormatter) }).reversed()
    }
}
