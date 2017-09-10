//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class NewsListInteractorImpl {
    weak var output: NewsListInteractorOutput?
    fileprivate var loadedItems: [NewsItem] = []
    
    init() {
    }
    
    func testItems() -> [NewsItem] {
        let string = rawTopResponse
        guard let data = string.data(using: .utf8) else {
            fatalError()
        }
        let object: [String: Any] = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
        let data1: [String: Any] = object["data"] as! [String: Any]
        let array = data1["children"] as! [[String: Any]]
        let models: [RedditEntryModel] = array.flatMap {
            guard let postDict = $0["data"] as? NSDictionary else {
                return nil
            }
            return try? RedditEntryModel(map: Map(dictionary: postDict))
        }
        return models.flatMap{
            entry in
            
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
}

private var fetchCounts: Int = 0

extension NewsListInteractorImpl: NewsListInteractorInput {
    func fetchNewsList() {
//        if (fetchCounts < 2) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                self.output?.didFail(error: NewsListError(text: "Test failure"))
//            }
//            fetchCounts += 1
//        }
//        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                let items = self.testItems()
                self.loadedItems.append(contentsOf: items)
                self.output?.didLoad(news: self.loadedItems)
            }
//        }
    }
    
    func fetchNextItems() {
        if (fetchCounts < 2) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                let items = self.testItems()
//                self.loadedItems.append(contentsOf: items)
                self.output?.didFailLoadingNext(error: NewsListError(text: "fff"))
            }
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                let items = self.testItems()
                self.loadedItems.append(contentsOf: items)
                self.output?.didLoadNext(news: self.loadedItems)
            }
        }
        fetchCounts += 1
        
        
    }
}
