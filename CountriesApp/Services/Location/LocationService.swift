//
//  LocationService.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 14/05/2026.
//

import Foundation
import CoreLocation


protocol LocationServiceProtocol {
    func requestLocation() async throws -> CLLocation
}


/// Service responsible for handling location permission
/// and fetching the current user location using CoreLocation.
final class LocationService: NSObject, LocationServiceProtocol {

    private let manager = CLLocationManager()

    private var locationContinuation: CheckedContinuation<CLLocation, Error>?
    private var permissionContinuation: CheckedContinuation<CLAuthorizationStatus, Never>?

    override init() {
        super.init()
        manager.delegate = self
    }

    /// Requests the current user location.
    ///
    /// Flow:
    /// 1. Resolves the current authorization status.
    /// 2. Requests permission if needed.
    /// 3. Fetches the current location when permission is granted.
    ///
    /// - Returns: Current device location.
    func requestLocation() async throws -> CLLocation {
        let status = await resolvedAuthorizationStatus()

        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            return try await fetchLocation()

        case .denied, .restricted:
            throw LocationError.permissionDenied

        case .notDetermined:
            throw LocationError.permissionDenied

        @unknown default:
            throw LocationError.permissionDenied
        }
    }

    
    /// Resolves the current authorization status.
    ///
    /// If the status is `.notDetermined`,
    /// the system location permission dialog will appear
    /// and the async flow waits until the user responds.
    ///
    /// - Returns: Final authorization status selected by the user.
    private func resolvedAuthorizationStatus() async -> CLAuthorizationStatus {
        let status = manager.authorizationStatus

        guard status == .notDetermined else { return status }

        return await withCheckedContinuation { continuation in
            self.permissionContinuation = continuation
            manager.requestWhenInUseAuthorization()
        }
    }
    
    /// Requests the current device location.
    ///
    /// The async flow waits until CoreLocation returns
    /// either a valid location or an error.
    ///
    /// - Returns: Current device location.
    private func fetchLocation() async throws -> CLLocation {
        return try await withCheckedThrowingContinuation { continuation in
            self.locationContinuation = continuation
            manager.requestLocation()
        }
    }
}


/// CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard manager.authorizationStatus != .notDetermined else { return }
        permissionContinuation?.resume(returning: manager.authorizationStatus)
        permissionContinuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationContinuation?.resume(returning: location)
        locationContinuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationContinuation?.resume(throwing: error)
        locationContinuation = nil
    }
}


/// Errors

enum LocationError: Error {
    case permissionDenied
    case locationUnavailable
}
