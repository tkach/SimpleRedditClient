//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

struct Map {
    private let json: NSDictionary
    init(dictionary: NSDictionary) {
        json = dictionary
    }

    func from<T: Convertible>(_ field: String) throws -> T where T == T.ConvertedType {
        return try self.from(field, transformation: T.fromMap)
    }

    func from<T>(_ field: String, transformation: (Any) throws -> T) throws -> T {
        return try transformation(try self.JSONFromField(field))
    }
    
    private func JSONFromField(_ field: String) throws -> Any {
        if let value = field.isEmpty ? self.json : self.json.safeValue(forKeyPath: field) {
            return value
        }
        throw MappingError.fieldNotFound(field: field)
    }
}
