//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

extension NSDictionary {
    @nonobjc
    func safeValue(forKeyPath keyPath: String) -> Any? {
        var object: Any? = self
        var keys = keyPath.characters.split(separator: ".").map(String.init)

        while !keys.isEmpty, let currentObject = object {
            let key = keys.remove(at: 0)
            object = (currentObject as? NSDictionary)?[key]
        }

        return object
    }
}
