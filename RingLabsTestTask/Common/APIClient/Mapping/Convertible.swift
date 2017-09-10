//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

protocol Convertible {
    associatedtype ConvertedType = Self

    static func fromMap(_ value: Any) throws -> ConvertedType
}

protocol DefaultConvertible: Convertible {}

extension DefaultConvertible {
    public static func fromMap(_ value: Any) throws -> ConvertedType {
        if let object = value as? ConvertedType {
            return object
        }
        throw MappingError.cantConvert(value: value)
    }
}

extension String: DefaultConvertible {}
extension Int: DefaultConvertible {}
extension TimeInterval: DefaultConvertible {}
