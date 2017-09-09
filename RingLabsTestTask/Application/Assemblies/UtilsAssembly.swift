//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

final class UtilsAssembly {
    private (set) var imageLoader: ImageLoader


    init() {
        imageLoader = ImageLoaderImpl()
    }
}
