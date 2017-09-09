//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

struct NewsListError: Error {
    let text: String?
}

enum NewsListViewState {
    case loading
    case failed(NewsListError)
    case loaded(NewsListViewModel)
}
