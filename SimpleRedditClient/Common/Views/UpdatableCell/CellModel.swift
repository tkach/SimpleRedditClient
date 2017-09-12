//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

protocol CellModel {
    static func reuseIdentifier() -> String
}

extension CellModel {
    func reuseIdentifier() -> String {
        return type(of: self).reuseIdentifier()
    }

    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
