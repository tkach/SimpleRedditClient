//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class NewsListInteractorImpl {
    weak var output: NewsListInteractorOutput?
    fileprivate let newsListService: NewsListService
    fileprivate let newsItemBuilder: NewsItemBuilder
    
    init(newsListService: NewsListService) {
        self.newsListService = newsListService
        newsItemBuilder = NewsItemBuilder()
    }
}

extension NewsListInteractorImpl: NewsListInteractorInput {
    func fetchNewsList() {
        newsListService.loadNewsList() {
            [weak self] result in
            switch (result) {
            case .success(let response):
                self?.didLoad(response: response)
            case .error(let error):
                self?.didFail(with: error, loadingNext: false)
            }
        }
    }

    func fetchNextItems() {
        newsListService.loadNextNewsList() {
            [weak self] result in
            switch (result) {
            case .success(let response):
                self?.didLoad(next: true, response: response)
            case .error(let error):
                self?.didFail(with: error, loadingNext: true)
            }
        }
    }

    private func didLoad(next: Bool = false, response: EntriesListResponse) {
        let news = response.list.map { self.newsItemBuilder.build(from: $0) }
        output?.didLoad(page: NewsListPage(news: news, hasNext: true))
    }

    private func didFail(with error: NetworkError, loadingNext: Bool) {
        if (loadingNext) {
            output?.didFailLoadingNext(error: NewsListError(text: "Network Failure"))
        }
        else {
            output?.didFail(error: NewsListError(text: "Network Failure"))
        }
    }
}
