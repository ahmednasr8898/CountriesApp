//
//  CountriesView.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 14/05/2026.
//

import SwiftUI

struct CountriesView: View {

    // MARK: - Properties

    @StateObject private var viewModel = CountriesViewModel()
    
    
    // MARK: - Body

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                /// Search Bar
                searchBar

                /// Countries list Results
                if !viewModel.searchText.isEmpty {
                    searchResultsView
                } else {
                    selectedCountriesView
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Countries")
            .task {
                await viewModel.fetchCountries()
            }
            .onChange(of: viewModel.searchText) { _, newValue in
                viewModel.searchCountries(query: newValue)
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .alert(
                "Error",
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil },
                    set: { _ in viewModel.errorMessage = nil }
                )
            ) {
                Button("OK") { }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}


// MARK: - Views

extension CountriesView {

    private var searchBar: some View {

        HStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)

            TextField(
                "Search country",
                text: $viewModel.searchText
            )
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }


    private var searchResultsView: some View {
        List(viewModel.searchCountriesResults, id: \.name?.common) { country in

            CountryRowView(country: country,
                           isSelected: false) {
                viewModel.addCountry(country)
                viewModel.searchText = ""
            }
        }
        .listStyle(.plain)
    }

    
    private var selectedCountriesView: some View {
        List {
            ForEach(viewModel.selectedCountries, id: \.name?.common) { country in
                NavigationLink {
                    CountryDetailsView(country: country)
                } label: {
                    CountryRowView(
                        country: country,
                        isSelected: true
                    ) {
                        viewModel.removeCountry(country)
                    }
                }
            }
            .onDelete { indexSet in

                indexSet.forEach { index in
                    let country = viewModel.selectedCountries[index]
                    viewModel.removeCountry(country)
                }
            }
        }
        .listStyle(.plain)
    }
}



// MARK: - Preview

#Preview {
    CountriesView()
}
