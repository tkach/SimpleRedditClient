//
//  UIView+Nib.swift
//  RingLabsTestTask
//
//  Created by Alexander Tkachenko on 9/9/17.
//
//

import UIKit

extension UIView {
    static func fromNib<T>() -> T where T: UIView {
        let type = self
        let bundle = Bundle(for: type)
        let nibName = String(describing: type)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
        guard let content = views.first as? T else {
            fatalError("Error :: Couldn't load \(nibName) from nib")
        }
        return content
    }
}
