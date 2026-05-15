//
//  MockLocationService.swift
//  CountriesAppTests
//
//  Created by Ahmed Nasr on 15/05/2026.
//

import Foundation
import CoreLocation
@testable import CountriesApp


final class MockLocationService: LocationServiceProtocol {

    var result: Result<CLLocation, Error>!

    func requestLocation() async throws -> CLLocation {
        switch result {
        case .success(let location):
            return location
        case .failure(let error):
            throw error
        case .none:
            throw NSError(domain: "mock", code: 0)
        }
    }
}
