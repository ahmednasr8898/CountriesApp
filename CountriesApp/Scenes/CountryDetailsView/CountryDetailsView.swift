//
//  CountryDetailsView.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 15/05/2026.
//

import SwiftUI


struct CountryDetailsView: View {

    let country: CountryModel

    var body: some View {

            VStack(spacing: 24) {

                /// Country name header
                Text(country.name?.common ?? "")
                    .font(.system(size: 34, weight: .bold))
                    .multilineTextAlignment(.center)


                /// country info [capital, currency]
                detailsCard

                Spacer()
            }
            .padding()
        
        .navigationTitle("Country Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


/// info section [capital, currency]
extension CountryDetailsView {

    private var detailsCard: some View {

        VStack(spacing: 16) {

            detailRow(title: "capital city", value: country.capital?.first ?? "N/A")
            
            Divider()
            
            detailRow(title: "Currency", value: currencyText)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
        )
    }
    
    /// currency [name, symbol]
    private var currencyText: String {

        guard let currencies = country.currencies,
              let first = currencies.first else {
            return "N/A"
        }

        return "\(first.value.name) (\(first.value.symbol))"
    }
}


/// info details row
extension CountryDetailsView {

    private func detailRow(title: String, value: String) -> some View {

        HStack {

            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .font(.body)
                .fontWeight(.medium)
        }
    }
}
