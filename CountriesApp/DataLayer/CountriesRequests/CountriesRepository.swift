//
//  CountriesRepository.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 14/05/2026.
//

import Foundation


protocol CountriesRepository {
    func fetchCountries() async throws -> [CountryModel]
}

final class CountriesRepositoryImpl: CountriesRepository {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchCountries() async throws -> [CountryModel] {
        let request = CountriesAPIRequest()
        return try await apiClient.send(request)
    }
}
