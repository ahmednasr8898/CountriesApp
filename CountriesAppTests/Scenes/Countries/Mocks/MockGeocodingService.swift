//
//  MockGeocodingService.swift
//  CountriesAppTests
//
//  Created by Ahmed Nasr on 15/05/2026.
//

import Foundation
import CoreLocation
@testable import CountriesApp


final class MockGeocodingService: GeocodingServiceProtocol {

    var result: Result<String, Error>!

    func getCountry(from location: CLLocation) async throws -> String {
        switch result {
        case .success(let country):
            return country
        case .failure(let error):
            throw error
        case .none:
            return "Egypt"
        }
    }
}
