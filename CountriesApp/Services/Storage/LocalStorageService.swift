//
//  LocalStorageService.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 15/05/2026.
//

import Foundation


final class LocalStorageService<T: Codable> {

    
    private let key: String

    
    init(key: String) {
        self.key = key
    }
    

    func save(_ value: T) {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    
    func load() -> T? {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }

        return decoded
    }
}
