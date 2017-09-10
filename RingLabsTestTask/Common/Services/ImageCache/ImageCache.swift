//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

protocol ImageCache {
    func image(forUrl: URL) -> UIImage?
    func set(image: UIImage, forUrl: URL)
}
