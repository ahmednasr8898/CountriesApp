//
//  CountryDetailsViewModelTests.swift
//  CountriesAppTests
//
//  Created by Ahmed Nasr on 16/05/2026.
//

import XCTest
@testable import CountriesApp


final class CountryDetailsViewModelTests: XCTestCase {

    
    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    
    func test_countryName_returns_country_name() {

        let country = CountryModel(
            flags: nil,
            name: .init(common: "Egypt", official: nil),
            currencies: nil,
            capital: nil
        )

        let viewModel = CountryDetailsViewModel(country: country)

        XCTAssertEqual(viewModel.countryName, "Egypt")
    }

    
    func test_countryName_returns_NA_when_name_is_nil() {

        let country = CountryModel(
            flags: nil,
            name: nil,
            currencies: nil,
            capital: nil
        )

        let viewModel = CountryDetailsViewModel(country: country)

        XCTAssertEqual(viewModel.countryName, "N/A")
    }

    
    func test_capitalCity_returns_capital_name() {

        // Given
        let country = CountryModel(
            flags: nil,
            name: nil,
            currencies: nil,
            capital: ["Cairo"]
        )

        let viewModel = CountryDetailsViewModel(country: country)

        // Then
        XCTAssertEqual(viewModel.capitalCity, "Cairo")
    }

    
    func test_capitalCity_returns_NA_when_capital_is_nil() {

        let country = CountryModel(
            flags: nil,
            name: nil,
            currencies: nil,
            capital: nil
        )

        let viewModel = CountryDetailsViewModel(country: country)

        XCTAssertEqual(viewModel.capitalCity, "N/A")
    }

    
    func test_currencyText_returns_formatted_currency() {

        let currencies = [
            "EGP": CurrencyModel(
                name: "Egyptian Pound",
                symbol: "£"
            )
        ]

        let country = CountryModel(
            flags: nil,
            name: nil,
            currencies: currencies,
            capital: nil
        )

        let viewModel = CountryDetailsViewModel(country: country)

        XCTAssertEqual(viewModel.currencyText, "Egyptian Pound (£)")
    }

    
    func test_currencyText_returns_NA_when_currency_is_nil() {

        let country = CountryModel(
            flags: nil,
            name: nil,
            currencies: nil,
            capital: nil
        )

        let viewModel = CountryDetailsViewModel(country: country)

        XCTAssertEqual(viewModel.currencyText, "N/A")
    }
}
