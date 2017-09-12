//
//  EntriesListAssembly.swift
//  RingLabsTestTask
//
//  Created by Alexander Tkachenko on 9/9/17.
//
//

import UIKit

extension UIViewController {
    class func fromStoryboard(name: String? = nil) -> Self {
        let name = name ?? String(describing: self)
        return instantiateFromStoryboardHelper(type: self, name: name)
    }
    
    private class func instantiateFromStoryboardHelper<T>(type: T.Type, name: String) -> T {
        let storyboard = UIStoryboard.init(name: name, bundle: nil)
        let identifier = String(describing: type)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
