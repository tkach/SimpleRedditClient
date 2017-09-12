//
//  UICollectionView+VisibleCell.swift
//
//  Created by Alexander Tkachenko on 9/9/17.
//
//

import UIKit

extension UICollectionView {
    var indexPathForVisibleItemAtCenter: IndexPath? {
        let centerPoint = CGPoint(x: contentOffset.x + frame.size.width / 2,
                                  y: contentOffset.y + frame.size.height / 2)
        return indexPathForItem(at: centerPoint)
    }
}
