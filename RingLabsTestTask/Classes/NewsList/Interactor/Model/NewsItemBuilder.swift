//
// Created by Alexander Tkachenko on 9/11/17.
//

import Foundation

final class NewsItemBuilder {
    func build(from entry: RedditEntryModel) -> NewsItem {
        let date = Date(timeIntervalSince1970: entry.created)
        let aspect = entry.thumbnail.aspect
        return NewsItem(title: entry.title,
                author: entry.author,
                comments: entry.comments,
                date: date,
                thumbnailUrl: entry.thumbnail.url,
                thumbnailAspect: aspect,
                originalUrl: entry.image.url)
    }
}
