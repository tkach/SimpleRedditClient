//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class ImageLoaderImpl {
    fileprivate let cache: ImageCache
    
    init(cache: ImageCache) {
        self.cache = cache
    }
}

extension ImageLoaderImpl: ImageLoader {
    func load(with url: URL, into: ImageTarget? = nil, completion: @escaping (ImageLoadingResult) -> ()) {
        DispatchQueue.global(qos: .background).async {
            if let cached = self.cache.image(forUrl: url) {
                DispatchQueue.main.async {
                    completion(.success(cached))
                }
            }
            else {
                URLSession.shared.dataTask(with: url) { (data, _, error) in
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data) {
                            self.cache.set(image: image, forUrl: url)
                            completion(.success(image))
                        }
                        else {
                            completion(.failure(ImageLoadingError(text: "ImageLoadError".localized())))
                        }
                    }
                    }.resume()
            }
        }
    }
}
