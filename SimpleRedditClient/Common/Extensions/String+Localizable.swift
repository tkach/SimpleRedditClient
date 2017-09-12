//
//  String+Localizable.swift
//  RingLabsTestTask
//
//  Created by Alexander Tkachenko on 9/10/17.
//
//

import Foundation

extension String {
    
    func localized() -> String {
        return localized(using: nil, in: .main)
    }
    
    func localized(in bundle: Bundle?) -> String {
        return localized(using: nil, in: bundle)
    }
    
    func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized(), arguments: arguments)
    }
    
    func pluralizedFormat(_ arguments: CVarArg...) -> String {
        return withVaList(arguments) {
            NSString(format: localized(), locale: NSLocale.current, arguments: $0) as String
        }
    }
    
    private func localized(using tableName: String?) -> String {
        return localized(using: tableName, in: .main)
    }
    
    private func localized(using tableName: String?, in bundle: Bundle?) -> String {
        let bundle: Bundle = bundle ?? .main
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value:"", comment: "")
    }
}
