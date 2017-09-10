//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

enum MappingError: Error {
    case fieldNotFound(field: String)
    case cantConvert(value: Any)
}
