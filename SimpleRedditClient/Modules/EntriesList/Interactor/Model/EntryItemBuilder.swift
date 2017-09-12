//
// Created by Alexander Tkachenko on 9/11/17.
//

import Foundation

final class EntryItemBuilder {
    func build(from entry: RedditEntryModel) -> EntryItem {
        let date = Date(timeIntervalSince1970: entry.created)
        let aspect = entry.thumbnail.aspect
        return EntryItem(title: entry.title,
                author: entry.author,
                comments: entry.comments,
                date: date,
                thumbnailUrl: entry.thumbnail.url,
                thumbnailAspect: aspect,
                originalUrl: entry.image.url)
    }
}
