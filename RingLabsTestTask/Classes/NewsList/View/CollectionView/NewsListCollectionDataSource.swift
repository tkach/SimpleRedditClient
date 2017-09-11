//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class NewsListCollectionDataSource: NSObject {
    fileprivate let model: NewsListCollectionModel
    fileprivate let dateFormatter = DateFormatter()
    var hasData: Bool {
        return model.count > 0
    }
    
    init(model: NewsListCollectionModel) {
        self.model = model
    }

    func registerCells(collectionView: UICollectionView) {
        registerCell(cell: NewsItemCell.self, collectionView: collectionView)
        registerCell(cell: LoadMoreCell.self, collectionView: collectionView)
    }
    
    func append(page: NewsListPage) -> (toDelete: [IndexPath], toInsert: [IndexPath]) {
        let indexPaths = model.append(page: page)
        return indexPaths
    }
    
    func updateLoadMore(state: LoadMoreState) -> IndexPath {
        return model.updateLoadmore(state: state)
    }
}

extension NewsListCollectionDataSource: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = model.cellModel(atIndexPath: indexPath)
        
        let identifier = cellModel.reuseIdentifier()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                for: indexPath)

        if let cell = cell as? NewsItemCell,
           let model = cellModel as? NewsItem {
            cell.dateFormatter = dateFormatter
            cell.update(with: model)
        }
        else if let cell = cell as? LoadMoreCell,
                let model = cellModel as? LoadMoreModel {
            cell.update(with: model)
        }
        else {
            fatalError("Cell is created but can be updated because type of cell and model is not listed in the cases above")
        }
        return cell

    }
}

private extension NewsListCollectionDataSource {
    func registerCell<T>(cell: T.Type, collectionView: UICollectionView) where T: UpdatableCell, T: UICollectionViewCell {
        let cellName = String(describing: cell)
        let identifier = cell.Model.reuseIdentifier()
        let nib = UINib(nibName: cellName, bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
