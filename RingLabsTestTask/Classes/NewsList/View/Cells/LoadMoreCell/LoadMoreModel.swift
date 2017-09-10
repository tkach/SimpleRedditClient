//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

enum LoadMoreState {
    case loading
    case failed
}

final class LoadMoreModel: CellModel {
    var state: LoadMoreState
    init(state: LoadMoreState) {
        self.state = state
    }
}
