//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

protocol EntriesListView: class {
    func didStartLoading()
    func didFailedLoading(error: EntriesListError)
    func didFailedLoadingMore(error: EntriesListError)
    func didLoad(page: EntriesPage)
}
