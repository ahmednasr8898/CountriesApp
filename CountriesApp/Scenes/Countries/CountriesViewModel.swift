//
//  CountriesViewModel.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 14/05/2026.
//

import Foundation


@MainActor
final class CountriesViewModel: ObservableObject {

    /// Private properties
    private var allCountries: [CountryModel] = []
    private let service: CountriesRepository

    
    /// Published properties
    @Published private(set) var selectedCountries: [CountryModel] = []
    @Published var searchText: String = ""
    @Published var searchCountriesResults: [CountryModel] = []

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?


    /// Init
    init(service: CountriesRepository = CountriesRepositoryImpl(apiClient: APIClient())) {
        self.service = service
    }
    
    
    func fetchCountries() async {
        isLoading = true
        errorMessage = nil

        do {
            let countries = try await service.fetchCountries()
            self.allCountries = countries

            setInitialCountry()

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
    
    private func setInitialCountry() {
        guard let first = allCountries.first else { return }
        selectedCountries = [first]
    }
    
    
    func searchCountries(query: String) {

        guard !query.isEmpty else {
            searchCountriesResults = []
            return
        }

        searchCountriesResults = allCountries.filter {
            $0.name?.common?
                .lowercased()
                .contains(query.lowercased()) ?? false
        }
    }
    
    
    func addCountry(_ country: CountryModel) {

        guard selectedCountries.count < 5 else {
            errorMessage = "You can select up to 5 countries only."
            return
        }

        guard !selectedCountries.contains(where: {
            $0.name?.common == country.name?.common
        }) else { return }

        selectedCountries.append(country)
    }
    
    
    func removeCountry(_ country: CountryModel) {
        selectedCountries.removeAll {
            $0.name?.common == country.name?.common
        }
    }
}
