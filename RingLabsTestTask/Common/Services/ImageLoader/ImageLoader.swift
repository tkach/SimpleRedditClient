//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

enum ImageLoadingResult {
    case success(UIImage)
    case failure
    var image: UIImage? {
        let result: UIImage?
        switch self {
            case .success(let img):
            result = img
            case .failure:
            result = nil
        }
        return result
    }
}

protocol ImageTarget {
    
}

protocol ImageLoader {
    func load(with: URL, into: ImageTarget?, completion: @escaping (ImageLoadingResult) -> ())
}
