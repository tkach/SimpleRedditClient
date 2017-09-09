//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class NewsListCollectionDataSource: NSObject {
    fileprivate let model: NewsListCollectionModel
    init(model: NewsListCollectionModel) {
        self.model = model
    }

    func registerCell<T>(cell: T.Type, action: (UINib, String) -> ()) where T: UpdatableCell {
        let cellName = String(describing: cell)
        let identifier = cell.Model.reuseIdentifier()
        
        let nib = UINib(nibName: cellName, bundle: Bundle.main)
        action(nib, identifier)
    }

    func update(with vm: NewsListViewModel) {
        model.rebuild(with: vm)
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
            cell.update(with: model)
            
        }
        else {
            fatalError("Cell is created but not updated because type of cell and model is not listed in the cases above")
        }
        return cell

    }

}
