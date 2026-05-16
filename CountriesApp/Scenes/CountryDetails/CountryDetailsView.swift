//
//  CountryDetailsView.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 15/05/2026.
//

import SwiftUI


struct CountryDetailsView: View {

    let viewModel: CountryDetailsViewModel

    var body: some View {

            VStack(spacing: 24) {

                /// Country name header
                Text(viewModel.countryName)
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
            
            detailRow(title: "capital city", value: viewModel.capitalCity)
            
            Divider()
            
            detailRow(title: "Currency", value: viewModel.currencyText)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
        )
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
