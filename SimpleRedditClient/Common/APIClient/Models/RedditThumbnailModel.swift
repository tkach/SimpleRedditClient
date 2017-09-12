//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

struct RedditThumbnailModel {
    let url: URL?
    let size: CGSize
    var aspect: CGFloat {
        return size.height == 0 ? 0 : size.width / size.height
    }
}
