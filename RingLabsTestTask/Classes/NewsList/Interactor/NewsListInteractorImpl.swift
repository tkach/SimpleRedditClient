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
        return array.map {
            let representation = $0 as! [String: Any]
            let postDict = representation["data"] as! [String: Any]
            var imageSource: String? = nil
            if let image = postDict["preview"] as? [String: Any] {
                if let img = image["images"] as? [[String: Any]] {
                    if let first = img.first as? [String: Any] {
                        if let source = first["source"] as? [String: Any] {
                            if let sourceString = source["url"] {
                                imageSource = sourceString as? String
                            }
                        }
                    }
                }
            }
            
            let thumbnailURL: URL? = (postDict["thumbnail"] as? String).map {
                _urlstring in
                return URL(string: _urlstring)
            } ?? nil
            let proportion: CGFloat
            if let width = postDict["thumbnail_width"] as? CGFloat,
                let height = postDict["thumbnail_height"] as? CGFloat {
                proportion = width / height
            }
            else {
                proportion = 0
            }
            let originalURL: URL? = imageSource.map {
                _urlstring in
                URL(string: _urlstring)
            } ?? nil
            
            return NewsItem(title: postDict["title"] as! String,
                            author: postDict["author"] as! String,
                            comments: 0,
                            date: Date(),
                            thumbnailUrl: thumbnailURL,
                            thumbnailAspect: proportion,
                            originalUrl: originalURL)
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
