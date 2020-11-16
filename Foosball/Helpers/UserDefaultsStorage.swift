//
//  UserDefaultsStorage.swift
//  Foosball
//
//  Created by Константин on 16.11.2020.
//

import Foundation

public struct UserDefaultsStorage {

    public enum Keys: String {
        case matches, players
    }

    public static func remove(for key: Keys) {
        UserDefaults.standard.set(nil, forKey: key.rawValue)
    }

    public static func set<T: Codable>(_ value: T?, for key: Keys) {
        if value == nil {
            remove(for: key)
            return
        }
        let data = (try? JSONEncoder().encode(value)) ?? Data()
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }

    public static func get<T: Codable>(for key: Keys) -> T? {
        if let data = UserDefaults.standard.data(forKey: key.rawValue) {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        return nil
    }

}
