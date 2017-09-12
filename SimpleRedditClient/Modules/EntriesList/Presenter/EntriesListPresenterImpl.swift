//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

final class EntriesListPresenterImpl {
    fileprivate unowned let view: EntriesListView
    fileprivate unowned let router: EntriesListRouter
    fileprivate let interactor: EntriesListInteractorInput
    
    init(view: EntriesListView, interactor: EntriesListInteractorInput, router: EntriesListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension EntriesListPresenterImpl: EntriesListPresenter {
    func viewLoaded() {
        view.didStartLoading()
        interactor.fetchNextEntries()
    }

    func didSelect(item: EntryItem) {
        router.route(to: item)
    }

    func didTapRetryLoading() {
        view.didStartLoading()
        interactor.fetchNextEntries()
    }
    
    func didScrollToEnd() {
        view.didStartLoading()
        interactor.fetchNextEntries()
    }
}

extension EntriesListPresenterImpl: EntriesListInteractorOutput {
    func didLoad(page: EntriesPage) {
        view.didLoad(page: page)
    }

    func didFail(error: EntriesListError) {
        view.didFailedLoading(error: error)
    }
    
    func didFailLoadingNext(error: EntriesListError) {
        view.didFailedLoadingMore(error: error)
    }
}

