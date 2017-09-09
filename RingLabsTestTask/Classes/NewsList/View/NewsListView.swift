//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

protocol NewsListView: class {
    func update(with: NewsListViewState)
}
