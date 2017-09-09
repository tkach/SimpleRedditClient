//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

protocol NewsListInteractorInput: class {
    func fetchNewsList()
}

protocol NewsListInteractorOutput: class {
    func didLoad(news: [NewsItem])
    func didLoadNext(news: [NewsItem])
    func didFail(error: NewsListError)
}
