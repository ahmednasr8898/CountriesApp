//
//  MockCountriesRepository.swift
//  CountriesAppTests
//
//  Created by Ahmed Nasr on 15/05/2026.
//

import Foundation
@testable import CountriesApp


final class MockCountriesRepository: CountriesRepository {

    var result: Result<[CountryModel], Error>!

    func fetchCountries() async throws -> [CountryModel] {
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        case .none:
            return []
        }
    }
}
