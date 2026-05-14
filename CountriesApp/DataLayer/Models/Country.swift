//
//  Country.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 14/05/2026.
//

import Foundation


/// CountryModel
struct CountryModel: Decodable {
    let flags: FlagsModel?
    let name: CountryNameModel?
    let currencies: [String: CurrencyModel]?
    let capital: [String]?
}


/// FlagsModel
struct FlagsModel: Decodable {
    let png: String?
    let svg: String?
    let alt: String?
}


/// CountryNameModel
struct CountryNameModel: Decodable {
    let common: String?
    let official: String?
}


/// CurrencyModel
struct CurrencyModel: Decodable {
    let name: String
    let symbol: String
}


extension CountryModel {
    /// The primary currency of the country.
    /// - Note: API returns currencies as a dictionary, so this returns the first available currency.
    var currency: CurrencyModel? {
        currencies?.first?.value
    }

    /// The display name of the country's primary currency.
    var currencyName: String? {
        currency?.name
    }

    /// The symbol of the country's primary currency.
    var currencySymbol: String? {
        currency?.symbol
    }
}
