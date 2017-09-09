//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

final class NewsListInteractorImpl {
    weak var output: NewsListInteractorOutput?
    
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
            return NewsItem(title: postDict["title"] as! String,
                            author: postDict["author"] as! String,
                            comments: 0, date: Date(),
                            thumbnailUrlString: postDict["thumbnail"] as? String)
        }
    }
}

private var fetchCounts: Int = 2

extension NewsListInteractorImpl: NewsListInteractorInput {
    func fetchNewsList() {
        if (fetchCounts < 2) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.output?.didFail(error: NewsListError(text: "Test failure"))
            }
            fetchCounts += 1
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.output?.didLoad(news: self.testItems())
            }
        }
    }
}
