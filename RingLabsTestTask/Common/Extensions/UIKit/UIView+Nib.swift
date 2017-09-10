//
//  UIView+Nib.swift
//  RingLabsTestTask
//
//  Created by Alexander Tkachenko on 9/9/17.
//
//

import UIKit

extension UIView {
    class func fromNib() -> Self {
        let type = self
        let bundle = Bundle(for: type)
        let nibName = String(describing: type)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        let view = instantiateFromNibHelper(type: self, name: nibName)
        return view
    }
    
    private class func instantiateFromNibHelper<T>(type: T.Type, name: String) -> T {
        let nib = UINib(nibName: name, bundle: nil)
        let identifier = String(describing: type)
        let views = nib.instantiate(withOwner: self, options: nil)
        guard let content = views.first as? T else {
            fatalError("Error :: Couldn't load \(name) from nib")
        }
        return content
    }
}