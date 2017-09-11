//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

final class NewsListPresenterImpl {
    fileprivate unowned let view: NewsListView
    fileprivate unowned let router: NewsListRouter
    fileprivate let interactor: NewsListInteractorInput
    
    init(view: NewsListView, interactor: NewsListInteractorInput, router: NewsListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension NewsListPresenterImpl: NewsListPresenter {
    func viewLoaded() {
        view.didStartLoading()
        interactor.fetchNewsList()
    }

    func didSelect(item: NewsItem) {
        router.route(to: item)
    }

    func didTapRetryLoading() {
        view.didStartLoading()
        interactor.fetchNewsList()
    }
    
    func didScrollToEnd() {
        view.didStartLoading()
        interactor.fetchNextItems()
    }
}

extension NewsListPresenterImpl: NewsListInteractorOutput {
    func didLoad(page: NewsListPage) {
        view.didLoad(page: page)
    }

    func didFail(error: NewsListError) {
        view.didFailedLoading(error: error)
    }
    
    func didFailLoadingNext(error: NewsListError) {
        view.didFailedLoadingMore(error: error)
    }

//    func didLoad(news: [NewsItem]) {
//        print("news count: \(news.count)")
//        self.news = news
//        view.update(with: .loaded(NewsListPage(news: news, hasNext: true, loadMoreFailed: false)))
//    }
//
//    func didLoadNext(news: [NewsItem]) {
//        self.news.append(contentsOf: news)
//        print("news count: \(news.count)")
//        view.update(with: .loaded(NewsListPage(news: news, hasNext: true, loadMoreFailed: false)))
//    }
//
//    func didFail(error: NewsListError) {
//        view.update(with: .failed(error))
//    }
//
//    func didFailLoadingNext(error: NewsListError) {
//        view.update(with: .loaded(NewsListPage(news: news, hasNext: true, loadMoreFailed: true)))
//    }
}

