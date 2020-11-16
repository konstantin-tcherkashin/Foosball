//
//  GameDataProvider.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import Foundation

protocol GameDataProvider {

    func matches() -> [Match]
    func players() -> [Player]
    func stats() -> [PlayerStats]

    func add(match: Match)
    func add(player: Player)
}
