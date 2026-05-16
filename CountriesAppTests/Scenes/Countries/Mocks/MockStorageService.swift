//
//  MockStorageService.swift
//  CountriesAppTests
//
//  Created by Ahmed Nasr on 15/05/2026.
//

import Foundation
@testable import CountriesApp


final class MockStorageService: StorageServiceProtocol {

    var saved: [CountryModel] = []
    var loadResult: [CountryModel]?

    func load() -> [CountryModel]? {
        loadResult
    }

    func save(_ items: [CountryModel]) {
        saved = items
    }
}
