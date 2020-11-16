//
//  ServiceLocator.swift
//  Foosball
//
//  Created by Константин on 16.11.2020.
//

import Foundation

final class ServiceLocator {

    static let shared = ServiceLocator()

    private init() { }


    lazy private(set) var gameDataProvider: GameDataProvider = UserDefaultsDataProvider()
}
