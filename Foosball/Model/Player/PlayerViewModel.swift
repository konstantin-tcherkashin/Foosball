//
//  PlayerViewModel.swift
//  Foosball
//
//  Created by Константин on 15.11.2020.
//

import Foundation

struct PlayerViewModel {

    var avatarImagePath: String?
    var name: String?

    init(_ player: Player?) {
        avatarImagePath = player?.avatarPath
        name = player?.name
    }
}
