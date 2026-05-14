//
//  APIRequest.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 14/05/2026.
//

import Foundation


/// A protocol defining the structure of an API request.
protocol APIRequest {
    /// The expected response type for the request.
    associatedtype Response: Decodable
    /// The URL request to be sent.
    var urlRequest: URLRequest { get }
}
