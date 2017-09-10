//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

protocol CollectionModel {
    var count: Int { get }
    
}

final class NewsListCollectionModel: CollectionModel {
    fileprivate var cellModels: [CellModel] = []
    var loadMoreInProgress: Bool = false {
        didSet {
            if let loadMoreModel = cellModels.last as? LoadMoreModel {
                loadMoreModel.state = loadMoreInProgress ? .loading : .failed
            }
        }
    }

    func rebuild(with model: NewsListViewModel) {
        loadMoreInProgress = model.loadMoreFailed == true
        cellModels = model.newsItemsLoaded
        if (model.hasMore) {
            let state: LoadMoreState = model.loadMoreFailed ? .failed : .loading
            let loadMore = LoadMoreModel(state: state)
            cellModels.append(loadMore)
        }
    }

    var count: Int { return cellModels.count }

    func cellModel(atIndexPath indexPath: IndexPath) -> CellModel {
        guard indexPath.row < cellModels.count else {
            fatalError("There is no cell model for current index path")
        }
        let cellModel = cellModels[indexPath.row]
        return cellModel
    }

}
