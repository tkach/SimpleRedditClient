//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class EntriesListInteractorImpl {
    weak var output: EntriesListInteractorOutput?
    fileprivate let entriesListService: EntriesListService
    fileprivate let entryItemBuilder: EntryItemBuilder
    fileprivate var loadedCount: Int = 0
    
    init(entriesListService: EntriesListService) {
        self.entriesListService = entriesListService
        entryItemBuilder = EntryItemBuilder()
    }
}

extension EntriesListInteractorImpl: EntriesListInteractorInput {
    struct Constants {
        static let totalToLoad = 50
    }

    func fetchNextEntries() {
        entriesListService.loadNextEntries() {
            [weak self] result in
            switch result {
            case .success(let response):
                self?.didLoad(response: response)
            case .error(let error):
                self?.didFail(with: error)
            }
        }
    }

    private func didLoad(response: EntriesListResponse) {
        let entries = response.list.map { self.entryItemBuilder.build(from: $0) }
        loadedCount += entries.count
        output?.didLoad(page: EntriesPage(entries: entries, hasNext: loadedCount < Constants.totalToLoad))
    }

    private func didFail(with error: NetworkError) {
        let isFirstPageFailed = loadedCount == 0
        if (isFirstPageFailed) {
            output?.didFail(error: EntriesListError(text: "NetworkError".localized()))
        }
        else {
            output?.didFailLoadingNext(error: EntriesListError(text: "NetworkError".localized()))
        }
    }
}
