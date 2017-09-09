//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

protocol CollectionModel {
    var count: Int { get }
    
}

final class NewsListCollectionModel: CollectionModel {
    fileprivate var cellModels: [CellModel] = []

    func rebuild(with model: NewsListViewModel) {
        cellModels = model.newsItemsLoaded
    }

    var count: Int {
        return cellModels.count
    }

    func cellModel(atIndexPath indexPath: IndexPath) -> CellModel {
        guard indexPath.row < cellModels.count else {
            fatalError("There is no cell model for current index path")
        }
        let cellModel = cellModels[indexPath.row]
        return cellModel
    }

}
