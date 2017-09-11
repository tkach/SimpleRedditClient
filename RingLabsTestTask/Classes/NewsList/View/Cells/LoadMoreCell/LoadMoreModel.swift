//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

enum LoadMoreState {
    case initial
    case loading
    case failed
    case disabled
}

final class LoadMoreModel: CellModel {
    var state: LoadMoreState
    init(state: LoadMoreState) {
        self.state = state
    }
}
