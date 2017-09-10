//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

protocol NewsListPresenter {
    func viewLoaded()
    
    func didSelect(item: NewsItem)
    func didShowLastPost()
    func didTapRetryLoading()
    func didScrollToEnd()
}
