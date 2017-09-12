//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

protocol EntriesListPresenter {
    func viewLoaded()
    func didSelect(item: EntryItem)
    func didTapRetryLoading()
    func didScrollToEnd()
}
