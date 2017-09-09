//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

protocol NewsListActionsDelegate: class {
    func on(newsItem: NewsItem)
}

final class NewsListCollectionDelegate: NSObject {
    private weak var actionsDelegate: NewsListActionsDelegate?
    weak var model: NewsListCollectionModel?
    var centeredIndexPath: IndexPath?
    init(actionsDelegate: NewsListActionsDelegate) {
        self.actionsDelegate = actionsDelegate
    }
}

extension NewsListCollectionDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let proposedSize = CGSize(width: collectionView.bounds.width - 50, height: 1000)
//        return proposedSize
        guard let model = model?.cellModel(atIndexPath: indexPath) else { fatalError()}
        
        let view = NewsItemCell.fromNib() as! NewsItemCell
        view.update(with: model as! NewsItem)
        var targetSize = proposedSize
        var widthPriority = UILayoutPriorityFittingSizeLevel
        var heightPriority = UILayoutPriorityFittingSizeLevel

            targetSize.height = view.frame.height
            heightPriority = UILayoutPriorityDefaultLow
            widthPriority = UILayoutPriorityRequired
        var contentView: UIView = view
        if let view = view as? UICollectionViewCell { contentView = view.contentView }
        let size = contentView.systemLayoutSizeFitting(targetSize,
                withHorizontalFittingPriority: widthPriority,
                verticalFittingPriority: heightPriority)
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }

    public func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        guard let indexPath = centeredIndexPath,
              let attributes = collectionView.layoutAttributesForItem(at: indexPath)
                else {
            return proposedContentOffset
        }
        let offsetY = attributes.frame.midY - collectionView.frame.size.height / 2
        let result = CGPoint(x: 0, y: max(0, offsetY.rounded()))
        return result
    }

}
