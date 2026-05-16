//
//  CountryStorageService.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 15/05/2026.
//

import Foundation


protocol StorageServiceProtocol {
    func load() -> [CountryModel]?
    func save(_ items: [CountryModel])
}


final class CountryStorageService: StorageServiceProtocol {

    private let storage = LocalStorageService<[CountryModel]>(key: LocalStorageKeys.selectedCountries)

    func load() -> [CountryModel]? {
        storage.load()
    }

    func save(_ items: [CountryModel]) {
        storage.save(items)
    }
}

