//
//  GeocodingService.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 14/05/2026.
//

import Foundation
import CoreLocation


/// Service responsible for converting geographic coordinates
/// into readable location information using reverse geocoding.
final class GeocodingService {

    private let geocoder = CLGeocoder()

    /// Retrieves the country name from the provided location.
    ///
    /// - Parameter location: The current device location.
    /// - Returns: The resolved country name.
    func getCountry(from location: CLLocation) async throws -> String {

        return try await withCheckedThrowingContinuation { continuation in

            geocoder.reverseGeocodeLocation(location) { placemarks, error in

                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                let country = placemarks?.first?.country ?? "Unknown"
                continuation.resume(returning: country)
            }
        }
    }
}
