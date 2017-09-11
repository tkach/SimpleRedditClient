//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

protocol CollectionModel {
    var count: Int { get }
    
}

final class NewsListCollectionModel: CollectionModel {
    fileprivate var cellModels: [CellModel] = []
    fileprivate var news: [NewsItem] = []
    private (set) var loadMoreState: LoadMoreState = .initial

    func append(page: NewsListPage) -> (toDelete: [IndexPath], toInsert: [IndexPath]) {
        let loadmoreIndex: Int? = cellModels.index { $0 is LoadMoreModel }
        cellModels = cellModels.flatMap { $0 as? NewsItem }
        
        let startingInsertIndex = news.count
        news.append(contentsOf: page.news)
        cellModels.append(contentsOf: page.news as [CellModel])
        if (page.hasNext) {
            loadMoreState = .initial
            let loadMore = LoadMoreModel(state: .initial)
            cellModels.append(loadMore)
        }
        var toDelete: [IndexPath] = []
        if let loadmoreIndex = loadmoreIndex {
            toDelete.append(IndexPath(item: loadmoreIndex, section: 0))
        }
        var toInsert: [IndexPath] = []
        let endingInsertIndex = cellModels.count - 1
        
        for i in startingInsertIndex...endingInsertIndex {
            toInsert.append(IndexPath(item: i, section: 0))
        }
        return (toDelete: toDelete, toInsert: toInsert)
    }
    
    func updateLoadmore(state: LoadMoreState) -> IndexPath {
        guard let loadMoreModel = cellModels.last as? LoadMoreModel else {
            fatalError("trying to update load more state, but loadmore cell is not added to collection")
        }
        loadMoreState = state
        loadMoreModel.state = state
        let index: Int = cellModels.count - 1
        return IndexPath(item: index, section: 0)
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
