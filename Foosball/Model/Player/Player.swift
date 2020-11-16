//
//  Player.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import Foundation

struct Player: Codable {

    var identifier: String
    var name: String
    var avatarPath: String?
    
}


extension Player: Equatable {

    static func ==(lhs: Player, rhs: Player) -> Bool {
        lhs.identifier == rhs.identifier
    }

}
