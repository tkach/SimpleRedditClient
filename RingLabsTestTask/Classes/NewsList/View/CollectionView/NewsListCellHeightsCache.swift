//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

final class NewsListCellHeightsCache {
    private var heights: [String: CGFloat] = [:]
    
    func store(height: CGFloat, for width: CGFloat, key: String) {
        let cacheKey = "\(width)" + key
        heights[cacheKey] = height
    }

    func fetch(for width: CGFloat, key: String) -> CGFloat? {
        let cacheKey = "\(width)" + key
        return heights[cacheKey]
    }
}
