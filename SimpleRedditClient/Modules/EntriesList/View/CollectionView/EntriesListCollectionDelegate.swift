//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

protocol EntriesListCollectionActionsDelegate: class {
    func on(entry: EntryItem)
    func onLoadMore()
}

final class EntriesListCollectionDelegate: NSObject {
    struct Constants {
        static let loadmoreCellHeight: CGFloat = 160
    }

    weak var model: EntriesListCollectionModel?
    var centeredIndexPath: IndexPath?

    fileprivate weak var actionsDelegate: EntriesListCollectionActionsDelegate?
    fileprivate let heightsCache = EntriesListCellHeightsCache()
    fileprivate lazy var tempEntryCell: EntryItemCell = { EntryItemCell.fromNib() }()
    
    init(actionsDelegate: EntriesListCollectionActionsDelegate) {
        self.actionsDelegate = actionsDelegate
    }
}

extension EntriesListCollectionDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        let itemWidth = collectionView.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right
        let estimatedSize = CGSize(width: itemWidth, height: Constants.loadmoreCellHeight)
        guard let model = model?.cellModel(atIndexPath: indexPath) as? EntryItemCell.Model else {
            return estimatedSize
        }
        let cacheKey = model.title
        let result: CGSize
        if let cached = heightsCache.fetch(for: itemWidth, key: cacheKey) {
            result = CGSize(width: itemWidth, height: cached)
        }
        else {
            tempEntryCell.update(with: model)
            result = tempEntryCell.systemLayoutSize(fixedWidth: itemWidth)
            heightsCache.store(height: result.height, for: itemWidth, key: cacheKey)
        }
        return result
    }

    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        guard let indexPath = centeredIndexPath,
              let centeredAttributes = collectionView.layoutAttributesForItem(at: indexPath)
                else {
            return proposedContentOffset
        }
        let offsetY = centeredAttributes.frame.midY - collectionView.frame.size.height / 2
        let result = CGPoint(x: 0, y: max(0, offsetY.rounded()))
        return result
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let model = model, model.count > 0, model.loadMoreState == .initial else { return }
        if (isInLoadmoreRange(scrollView: scrollView)) {
            actionsDelegate?.onLoadMore()
        }
    }

    private func isInLoadmoreRange(scrollView: UIScrollView) -> Bool {
        guard scrollView.contentSize.height > 0 else { return false }
        let distanceToTrigger = scrollView.frame.size.height
        let distanceToContentEnd = scrollView.contentSize.height - scrollView.contentOffset.y
        return distanceToContentEnd < distanceToTrigger
    }

    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let cellModel = model?.cellModel(atIndexPath: indexPath)
        if let model = cellModel as? LoadMoreModel {
            return model.state == .failed
        }
        else if let model = cellModel as? EntryItem {
            let canOpenDetails = model.originalUrl != nil
            return canOpenDetails
        }
        return false
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellModel = model?.cellModel(atIndexPath: indexPath)
        if let cellModel = cellModel as? EntryItem {
            actionsDelegate?.on(entry: cellModel)
        }
        else if let cellModel = cellModel as? LoadMoreModel, cellModel.state == .failed {
            actionsDelegate?.onLoadMore()
        }
    }
}
