//
//  CountryRowView.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 15/05/2026.
//

import SwiftUI


struct CountryRowView: View {

    let country: CountryModel
    let isSelected: Bool
    let action: () -> Void

    var body: some View {

        HStack(spacing: 16) {

            /// country flag
            CachedAsyncImage(url: country.flags?.png ?? "")
                .frame(width: 40, height: 25)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            
            
            /// country name
            Text(country.name?.common ?? "")
                .font(.headline)

            
            Spacer()

            
            /// action for add or remove country
            Button(action: action) {
                Image(systemName:
                        isSelected
                      ? "trash"
                      : "plus.circle"
                )
                .font(.title3)
            }
            .buttonStyle(.plain)
            
        }
        .padding(.vertical, 6)
    }
}
