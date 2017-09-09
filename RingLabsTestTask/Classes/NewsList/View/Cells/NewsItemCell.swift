//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

extension NewsItem: CellModel {}

protocol UpdatableCell {
    associatedtype Model: CellModel
    func update(with: Model)
}

final class NewsItemCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!

//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        let autoLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
//        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
//        let autoLayoutSize = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriorityRequired, verticalFittingPriority: UILayoutPriorityDefaultLow)
//        let autoLayoutFrame = CGRect(origin: autoLayoutAttributes.frame.origin, size: autoLayoutSize)
//        autoLayoutAttributes.frame = autoLayoutFrame
//        return autoLayoutAttributes
//    }

}

extension NewsItemCell: UpdatableCell {
    func update(with item: NewsItem) {
        title.text = item.title
    }
}
