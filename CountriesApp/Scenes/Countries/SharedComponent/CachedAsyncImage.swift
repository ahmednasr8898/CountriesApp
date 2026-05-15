//
//  CachedAsyncImage.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 15/05/2026.
//

import SwiftUI



struct CachedAsyncImage: View {
    
    @StateObject private var loader = ImageLoader()
    
    let url: String
    
    var body: some View {
        
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
                    .onAppear {
                        loader.load(url: url)
                    }
            }
        }
    }
}
