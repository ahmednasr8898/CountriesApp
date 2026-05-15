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

    /// Location properties
    private let locationService = LocationService()
    private let geocodingService = GeocodingService()
    
    /// Published properties
    @Published private(set) var selectedCountries: [CountryModel] = []
    @Published var searchText: String = ""
    @Published var searchCountriesResults: [CountryModel] = []

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    /// Storage properties
    private let storage = LocalStorageService<[CountryModel]>(key: LocalStorageKeys.selectedCountries)
    
    
    /// Init
    init(service: CountriesRepository = CountriesRepositoryImpl(apiClient: APIClient())) {
        self.service = service
    }
}


/// Fetch Countries & Initial Location
extension CountriesViewModel {
    func fetchCountries() async {
        isLoading = true
        errorMessage = nil

        do {
            let countries = try await service.fetchCountries()
            self.allCountries = countries

            await setInitialCountryFromGPS()

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
    
    private func setInitialCountryFromGPS() async {
        if let cashedSelectedCountries = storage.load(), !cashedSelectedCountries.isEmpty {
            selectedCountries = cashedSelectedCountries
            return
        }
        
        do {
            let location = try await locationService.requestLocation()
            let countryName = try await geocodingService.getCountry(from: location)

            if let matchedCountry = allCountries.first(where: {
                $0.name?.common?.lowercased() == countryName.lowercased()
            }) {
                selectedCountries = [matchedCountry]
                storage.save([matchedCountry])
            }

        } catch {
            setEgyptAsDefaultCountry()
        }
    }

    
    private func setEgyptAsDefaultCountry() {
        guard let egypt = allCountries.first(where: {
                $0.name?.common?.lowercased() == "egypt"
            }) else { return }

            selectedCountries = [egypt]
        storage.save([egypt])
    }
}


/// Search Countries
extension CountriesViewModel {
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
}


/// Manage Selected Countries
extension CountriesViewModel {
    func addCountry(_ country: CountryModel) {

        guard selectedCountries.count < 5 else {
            errorMessage = "You can select up to 5 countries only."
            return
        }

        guard !selectedCountries.contains(where: {
            $0.name?.common == country.name?.common
        }) else {
            errorMessage = "\(country.name?.common ?? "Country") is already selected."
            return
        }

        selectedCountries.append(country)
        storage.save(selectedCountries)
    }
    
    
    func removeCountry(_ country: CountryModel) {
        selectedCountries.removeAll {
            $0.name?.common == country.name?.common
        }
        storage.save(selectedCountries)
    }
}
