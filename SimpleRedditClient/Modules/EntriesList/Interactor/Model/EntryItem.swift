//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

struct EntryItem {
    let title: String
    let author: String
    let comments: Int
    let date: Date
    
    let thumbnailUrl: URL?
    let thumbnailAspect: CGFloat
    let originalUrl: URL?
}
