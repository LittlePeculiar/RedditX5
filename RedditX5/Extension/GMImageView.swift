//
//  GMImageView.swift
//  RedditX5
//
//  Created by Gina Mullins on 10/30/20.
//

import UIKit

extension UIImageView {
    func fetchImage(withURL url: URL?) {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let imageData = data else { return }
                self.image = UIImage(data: imageData)
            }
        }.resume()
    }
}
