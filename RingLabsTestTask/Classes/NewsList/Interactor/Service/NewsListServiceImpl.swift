//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

final class NewsListServiceImpl {
    
}

extension NewsListServiceImpl: NewsListService {
    func loadNewsList(completion: @escaping (NetworkResult<EntriesListResponse>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let response = self.testItems()
            completion(.success(response: response))
        }
    }


    func testItems() -> EntriesListResponse {
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

        let response = EntriesListResponse(list: models)
        return response
    }
}
