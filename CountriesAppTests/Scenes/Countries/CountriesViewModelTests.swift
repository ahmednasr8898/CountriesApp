//
//  CountriesViewModelTests.swift
//  CountriesAppTests
//
//  Created by Ahmed Nasr on 15/05/2026.
//

import XCTest
@testable import CountriesApp


@MainActor
final class CountriesViewModelTests: XCTestCase {

    // MARK: - Properties
    
    var viewModel: CountriesViewModel!

    var repo: MockCountriesRepository!
    var location: MockLocationService!
    var geo: MockGeocodingService!
    var storage: MockStorageService!

    
    // MARK: - life cycle
    
    override func setUpWithError() throws {
        repo = MockCountriesRepository()
        location = MockLocationService()
        geo = MockGeocodingService()
        storage = MockStorageService()
        viewModel = CountriesViewModel(
            service: repo,
            locationService: location,
            geocodingService: geo,
            storage: storage
        )
    }

    override func tearDownWithError() throws {
        repo = nil
        location = nil
        geo = nil
        storage = nil
        viewModel = nil
    }

    
    func test_fetchCountries_success() async {

        let egypt = CountryModel(flags: nil, name: .init(common: "Egypt", official: nil), currencies: nil, capital: nil)

        repo.result = .success([egypt])

        storage.loadResult = nil
        location.result = .failure(NSError())
        geo.result = .failure(NSError())


        await viewModel.fetchCountries()


        XCTAssertEqual(viewModel.selectedCountries.count, 1)
        XCTAssertEqual(viewModel.selectedCountries.first?.name?.common, "Egypt")
    }
    
    
    func test_searchCountries_filters_with_countries() async {

        let egypt = CountryModel(flags: nil, name: .init(common: "Egypt", official: nil), currencies: nil, capital: nil)

        let germany = CountryModel(flags: nil, name: .init(common: "Germany", official: nil), currencies: nil, capital: nil)

        repo.result = .success([egypt, germany])
        await viewModel.fetchCountries()
        
        viewModel.searchCountries(query: "eg")

        XCTAssertEqual(viewModel.searchCountriesResults.count, 1)
        XCTAssertEqual(viewModel.searchCountriesResults.first?.name?.common, "Egypt")
    }
    
    
    func test_addCountry_success() {

        let egypt = CountryModel(flags: nil, name: .init(common: "Egypt", official: nil), currencies: nil, capital: nil)

        viewModel.addCountry(egypt)

        XCTAssertEqual(viewModel.selectedCountries.count, 1)
        XCTAssertEqual(storage.saved.count, 1)
    }
    
    
    func test_addCountry_duplicate() {

        let egypt = CountryModel(flags: nil, name: .init(common: "Egypt", official: nil), currencies: nil, capital: nil)

        viewModel.addCountry(egypt)
        viewModel.addCountry(egypt)

        XCTAssertEqual(viewModel.selectedCountries.count, 1)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    
    func test_addCountry_maxLimit() {

        for i in 0..<6 {
            let country = CountryModel(
                flags: nil, name: .init(common: "Country \(i)", official: nil),
                currencies: nil,
                capital: nil
            )

            viewModel.addCountry(country)
        }

        XCTAssertEqual(viewModel.selectedCountries.count, 5)
        XCTAssertEqual(viewModel.errorMessage, "You can select up to 5 countries only.")
    }
    
    
    func test_removeCountry() {

        let egypt = CountryModel(flags: nil, name: .init(common: "Egypt", official: nil), currencies: nil, capital: nil)

        viewModel.addCountry(egypt)
        viewModel.removeCountry(egypt)

        XCTAssertTrue(viewModel.selectedCountries.isEmpty)
    }
}
