//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

protocol NewsListView: class {
    func didStartLoading()
    func didFailedLoading(error: NewsListError)
    func didFailedLoadingMore(error: NewsListError)
    func didLoad(page: NewsListPage)
}
