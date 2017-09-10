//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

extension UICollectionViewCell {
    func systemLayoutSize(fixedWidth: CGFloat) -> CGSize {
        let targetSize = CGSize(width: fixedWidth, height: frame.height)
        let size = contentView.systemLayoutSizeFitting(targetSize,
                withHorizontalFittingPriority: UILayoutPriorityRequired,
                verticalFittingPriority: UILayoutPriorityDefaultLow)
        return CGSize(width: size.width.rounded(), height: size.height.rounded())
    }
}
