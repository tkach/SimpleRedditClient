//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class ImageLoadableView: UIView, ImageLoadable {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var placeholderView: UIView!
    @IBInspectable var animated: Bool = true
    
    private var image: UIImage?
    private var dirty: Bool { return image != imageView.image }
    
    func load(imageURL: URL?) {
        guard let url = imageURL else {
            image = nil
            return
        }
        
        imageLoader.load(with: url, into: self) {
            [weak self] result in
            self?.image = result.image
            self?.updateSubviews()
        }
    }
    
    func prepareForReuse() {
        image = nil
        imageView.image = nil
        imageView.alpha = 0
    }
    
    private func updateSubviews() {
        guard dirty else { return }
        let newAlpha: CGFloat = image == nil ? 0 : 1
        if animated {
            imageView.image = image
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [.allowUserInteraction, .beginFromCurrentState],
                           animations: {
                            self.imageView.alpha = newAlpha
            },
                           completion: nil)
        }
        else {
            imageView.alpha = newAlpha
            imageView.image = image
        }
    }
}
