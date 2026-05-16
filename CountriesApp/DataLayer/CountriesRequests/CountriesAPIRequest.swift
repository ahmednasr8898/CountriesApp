//
//  CountriesAPIRequest.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 14/05/2026.
//

import Foundation


struct CountriesAPIRequest: APIRequest {

    typealias Response = [CountryModel]


    var urlRequest: URLRequest {
        var request = URLRequest(
            
            url: URL(string: "\(APIEnvironment.baseURL)/all?fields=name,capital,currencies,flags")!
        )
        request.httpMethod = "GET"
        return request
    }
}
