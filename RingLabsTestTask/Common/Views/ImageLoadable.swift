//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

protocol ImageLoadable: ImageTarget {
    var imageLoader: ImageLoader { get }
}

extension ImageLoadable {
    var imageLoader: ImageLoader {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can't locate appDelegate")
        }
        let loader = appDelegate.appAssembly.utilsAssembly.imageLoader
        return loader
    }
}
