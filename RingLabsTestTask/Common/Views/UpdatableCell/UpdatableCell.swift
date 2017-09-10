//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

protocol UpdatableCell {
    associatedtype Model: CellModel
    func update(with: Model)
}
