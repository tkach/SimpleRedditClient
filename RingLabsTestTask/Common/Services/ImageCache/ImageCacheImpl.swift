//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

final class ImageCacheImpl {
    let cache: NSCache<NSString, UIImage>
    init(cache: NSCache<NSString, UIImage>) {
        self.cache = cache
    }
}

extension ImageCacheImpl: ImageCache {
    func image(forUrl url: URL) -> UIImage? {
        let key = url.absoluteString as NSString
        return cache.object(forKey: key)
    }

    func set(image: UIImage, forUrl: URL) {
        let key = forUrl.absoluteString as NSString
        cache.setObject(image, forKey: key)
    }
}
