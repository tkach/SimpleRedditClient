//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

final class UtilsAssembly {
    private (set) var imageLoader: ImageLoader


    init() {
        let cache = ImageCacheImpl(cache: NSCache<NSString, UIImage>())
        imageLoader = ImageLoaderImpl(cache: cache)
    }
}
