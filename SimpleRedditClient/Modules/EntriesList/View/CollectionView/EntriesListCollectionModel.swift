//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

final class EntriesListCollectionModel {
    fileprivate var cellModels: [CellModel] = []
    private (set) var loadMoreState: LoadMoreState = .initial
    var count: Int { return cellModels.count }
    
    func append(page: EntriesPage) -> (toDelete: [IndexPath], toInsert: [IndexPath]) {
        let loadmoreIndex: Int? = cellModels.index { $0 is LoadMoreModel }
        cellModels = cellModels.flatMap { $0 as? EntryItem }
        
        let startingInsertIndex = cellModels.count
        cellModels.append(contentsOf: page.entries as [CellModel])
        if (page.hasNext) {
            loadMoreState = .initial
            let loadMore = LoadMoreModel(state: loadMoreState)
            cellModels.append(loadMore)
        }
        else {
            loadMoreState = .disabled
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
        let loadmoreIndex: Int = cellModels.count - 1
        return IndexPath(item: loadmoreIndex, section: 0)
    }

    func cellModel(atIndexPath indexPath: IndexPath) -> CellModel {
        guard indexPath.row < cellModels.count else {
            fatalError("There is no cell model for given index path")
        }
        let cellModel = cellModels[indexPath.row]
        return cellModel
    }

}
