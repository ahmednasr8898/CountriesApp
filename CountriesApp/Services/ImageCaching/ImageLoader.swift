//
//  ImageLoader.swift
//  CountriesApp
//
//  Created by Ahmed Nasr on 15/05/2026.
//

import UIKit


final class ImageLoader: ObservableObject {

    @Published var image: UIImage?

    func load(url: String) {

        if let cached = ImageCache.shared.object(forKey: url as NSString) {
            self.image = cached
            return
        }

        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data,
                  let image = UIImage(data: data) else { return }

            ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString)

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
