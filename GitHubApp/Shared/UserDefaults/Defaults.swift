//
//  Defaults.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 03.03.2021..
//

import Foundation

enum DefaultsKey: String {
    case repositories
    case users
    case lastSearch
}

struct Defaults {
    private static let userDefaults = UserDefaults.standard
    
    static func isRepositoriesSelected() -> Bool {
        let isSelected = userDefaults.bool(forKey: DefaultsKey.repositories.rawValue)
        return isSelected
    }
    
    static func isUsersSelected() -> Bool {
        if userDefaults.value(forKey: DefaultsKey.users.rawValue) == nil {
            userDefaults.set(true, forKey: DefaultsKey.users.rawValue)
        }
        let isSelected = userDefaults.bool(forKey: DefaultsKey.users.rawValue)
        return isSelected
    }
    
    static func saveRepositorySelection(_ selected: Bool) {
        userDefaults.set(selected, forKey: DefaultsKey.repositories.rawValue)
    }
    
    static func saveUsersSelection(_ selected: Bool) {
        userDefaults.set(selected, forKey: DefaultsKey.users.rawValue)
    }
    
    static func getLastSearch() -> String {
        let lastQuery = userDefaults.string(forKey: DefaultsKey.lastSearch.rawValue)
        return lastQuery ?? ""
    }
    
    static func saveLastSearch(_ lastSearch: String) {
        userDefaults.set(lastSearch, forKey: DefaultsKey.lastSearch.rawValue)
    }
}
