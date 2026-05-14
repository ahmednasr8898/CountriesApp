//
//  NetworkService.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 14/05/2026.
//

import Foundation


/// A protocol defining the structure of an API request.
protocol APIClientProtocol {
    /// Sends an API request and returns the response.
    /// - Parameter request: The API request to be sent.
    /// - Returns: The response of the API request.
    func send<R: APIRequest>(_ request: R) async throws -> R.Response
}

/// A class responsible for sending API requests.
final class APIClient: APIClientProtocol {

    /// Sends an API request and returns the response.
    func send<R: APIRequest>(_ request: R) async throws -> R.Response {

        /// Perform the network request
        let (data, response) = try await URLSession.shared.data(
            for: request.urlRequest
        )

        /// Validate the response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        /// Check for successful status code
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        /// Decode and return the response
        return try JSONDecoder().decode(R.Response.self, from: data)
    }
}
