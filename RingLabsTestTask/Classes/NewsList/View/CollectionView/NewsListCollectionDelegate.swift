//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

protocol NewsListCollectionActionsDelegate: class {
    func on(newsItem: NewsItem)
    func onLoadMore()
}

final class NewsListCollectionDelegate: NSObject {
    fileprivate weak var actionsDelegate: NewsListCollectionActionsDelegate?
    weak var model: NewsListCollectionModel?
    var centeredIndexPath: IndexPath?
    init(actionsDelegate: NewsListCollectionActionsDelegate) {
        self.actionsDelegate = actionsDelegate
    }
}

extension NewsListCollectionDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        let itemWidth = collectionView.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right
        
        let proposedSize = CGSize(width: itemWidth, height: 60)
        guard let model = model?.cellModel(atIndexPath: indexPath) as? NewsItemCell.Model else {
            return proposedSize
        }
        let view = NewsItemCell.fromNib()
        view.update(with: model)
        return view.systemLayoutSize(fixedWidth: itemWidth)
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

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let model = model else { return }
        if (model.count > 0 && needToTriggerLoadMore(scrollView: scrollView) && !model.loadMoreInProgress) {
            model.loadMoreInProgress = true
            actionsDelegate?.onLoadMore()
        }
    }

    private func needToTriggerLoadMore(scrollView: UIScrollView) -> Bool {
        guard scrollView.contentSize.height > 0 else { return false }
        return scrollView.contentSize.height - scrollView.contentOffset.y < scrollView.frame.size.height * 2
    }

    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let cellModel = model?.cellModel(atIndexPath: indexPath)
        if let cellModel = cellModel as? LoadMoreModel, cellModel.state != .failed {
            return false
        }
        return true
    }


    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellModel = model?.cellModel(atIndexPath: indexPath)
        if let cellModel = cellModel as? NewsItem {
            actionsDelegate?.on(newsItem: cellModel)
        }
        else if let cellModel = cellModel as? LoadMoreModel, cellModel.state == .failed {
            actionsDelegate?.onLoadMore()
            model?.loadMoreInProgress = true
        }
    }

}
