//
//  UIImageView+Ext.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import UIKit

extension UIImageView {
    private static let cache = NSCache<NSString, UIImage>()
    
    private func cacheImageSetter(with link: String, and image: UIImage) {
        let cacheKey = NSString(string: link)
        UIImageView.cache.setObject(image, forKey: cacheKey)
    }
    
    private func cacheImageGetter(of link: String) -> UIImage? {
        let cacheKey = NSString(string: link)
        let image = UIImageView.cache.object(forKey: cacheKey)
        return image
    }
    
    private func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            self.cacheImageSetter(with: url.absoluteString, and: image)
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String?, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let link else { return }
        if let image = cacheImageGetter(of: link) {
            self.image = image
            return
        }
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
