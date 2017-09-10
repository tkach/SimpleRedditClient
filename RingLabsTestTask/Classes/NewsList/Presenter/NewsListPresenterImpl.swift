//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

final class NewsListPresenterImpl {
    fileprivate unowned let view: NewsListView
    fileprivate unowned let router: NewsListRouter
    fileprivate let interactor: NewsListInteractorInput
    
    fileprivate var news: [NewsItem] = []

    init(view: NewsListView, interactor: NewsListInteractorInput, router: NewsListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension NewsListPresenterImpl: NewsListPresenter {
    func viewLoaded() {
        view.update(with: .loading)
        interactor.fetchNewsList()
    }

    func didSelectPost() {
        print("did select post")
    }

    func didShowLastPost() {
        print("did show last post")
    }

    func didTapRetryLoading() {
        interactor.fetchNewsList()
        view.update(with: .loading)
        print("did tap retry loading")
    }
    
    func didScrollToEnd() {
        interactor.fetchNextItems()
    }
}

extension NewsListPresenterImpl: NewsListInteractorOutput {
    func didLoad(news: [NewsItem]) {
        self.news = news
        view.update(with: .loaded(NewsListViewModel(newsItemsLoaded: news, hasMore: true, loadMoreFailed: false)))
    }

    func didLoadNext(news: [NewsItem]) {
        self.news = news
        view.update(with: .loaded(NewsListViewModel(newsItemsLoaded: news, hasMore: true, loadMoreFailed: false)))
    }

    func didFail(error: NewsListError) {
        view.update(with: .failed(error))
    }
    
    func didFailLoadingNext(error: NewsListError) {
        view.update(with: .loaded(NewsListViewModel(newsItemsLoaded: news, hasMore: true, loadMoreFailed: true)))
    }
}

