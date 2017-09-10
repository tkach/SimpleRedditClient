//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class NewsListInteractorImpl {
    weak var output: NewsListInteractorOutput?
    fileprivate var loadedItems: [NewsItem] = []
    fileprivate let newsListService: NewsListService
    
    init(newsListService: NewsListService) {
        self.newsListService = newsListService
    }
}

extension NewsListInteractorImpl: NewsListInteractorInput {
    func fetchNewsList() {
        newsListService.loadNewsList() {
            [weak self] result in
            switch(result) {
            case .success(let response):
                self?.didLoad(response: response)
            case .error(let error):
                self?.didFail(with: error)
            }
        }
    }

    func fetchNextItems() {
        newsListService.loadNextNewsList() {
            result in
            switch(result) {
            case .success(let response):
                self.didLoad(next: true, response: response)
            case .error(let error):
                self.didFail(with: error)
            }
        }
//        newsListService.loadNewsList {
//            [weak self] result in
//            switch(result) {
//            case .success(let response):
//                self?.didLoad(response: response)
//            case .error(let error):
//                self?.didFail(with: error)
//            }
//        }
//        if (fetchCounts < 2) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                let items = self.testItems()
//                self.loadedItems.append(contentsOf: items)
//                self.output?.didFailLoadingNext(error: NewsListError(text: "fff"))
//            }
//        }
//        else {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                let items = self.testItems()
//                self.loadedItems.append(contentsOf: items)
//                self.output?.didLoadNext(news: self.loadedItems)
//            }
//        }
    }

    private func didLoad(next: Bool = false, response: EntriesListResponse) {
        let news = response.list.map {
                entry -> NewsItem in
                let date = Date(timeIntervalSince1970: entry.created)
                let aspect = entry.thumbnail.aspect
                return NewsItem(title: entry.title,
                        author: entry.author,
                        comments: entry.comments,
                        date: date,
                        thumbnailUrl: entry.thumbnail.url,
                        thumbnailAspect: aspect,
                        originalUrl: entry.image.url)
        }
        if (next) {
            loadedItems.append(contentsOf: news)
            output?.didLoadNext(news: loadedItems)
        }
        else {
            loadedItems.append(contentsOf: news)
            output?.didLoad(news: loadedItems)
        }
    }

    private func didFail(with error: NetworkError) {
        output?.didFail(error: NewsListError(text: "Network Failure"))
    }
}
