//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

protocol NewsListInteractorInput: class {
    func fetchNewsList()
    func fetchNextItems()
}

protocol NewsListInteractorOutput: class {
    func didLoad(news: [NewsItem])
    func didLoadNext(news: [NewsItem])
    func didFail(error: NewsListError)
    func didFailLoadingNext(error: NewsListError)
}
