//
//  CountryDetailsViewModel.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 16/05/2026.
//

import Foundation


struct CountryDetailsViewModel {

    /// Proprites
    private let country: CountryModel

    
    /// Init
    init(country: CountryModel) {
        self.country = country
    }

    
    /// Getter Proprites
    var countryName: String {
        country.name?.common ?? "N/A"
    }

    
    var capitalCity: String {
        country.capital?.first ?? "N/A"
    }

    
    var currencyText: String {
        guard let currencies = country.currencies,
              let first = currencies.first else {
            return "N/A"
        }

        return "\(first.value.name) (\(first.value.symbol))"
    }
}
