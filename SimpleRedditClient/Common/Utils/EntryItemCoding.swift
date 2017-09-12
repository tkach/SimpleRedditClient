//
// Created by Alexander Tkachenko on 9/13/17.
// Copyright (c) 2017 Alexander Tkachenko. All rights reserved.
//

import Foundation

final class EntryItemCoding {
    struct Constants {
        static var titleKey = "item.title"
        static var urlKey = "item.url"
        //we don't need another properties now
    }

    static func entryItem(with coder: NSCoder) -> EntryItem {
        let url = coder.decodeObject(forKey: Constants.urlKey) as? URL ?? nil
        let title = coder.decodeObject(forKey: Constants.titleKey) as? String ?? ""
        let item = EntryItem(title: title, author: "", comments: 0, date: Date(), thumbnailUrl: nil, thumbnailAspect: 0, originalUrl: url)
        return item
    }

    static func encode(item: EntryItem, with coder: NSCoder) {
        coder.encode(item.title, forKey: Constants.titleKey)
        coder.encode(item.originalUrl, forKey: Constants.urlKey)
    }
}
