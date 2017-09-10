//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

final class NewsListServiceImpl {
    fileprivate let apiClient: RedditAPIClient
    fileprivate var loaded: [RedditEntryModel]
    init(apiClient: RedditAPIClient) {
        self.apiClient = apiClient
        loaded = []
    }
}

extension NewsListServiceImpl: NewsListService {
    func loadNewsList(completion: @escaping (NetworkResult<EntriesListResponse>) -> ()) {
        let parameters = ListingParameters(limit: 20, after: nil, rawJson: true)
        apiClient.getTop(parameters: parameters) {
            result in
            switch (result) {
            case .success(let response):
                self.loaded.append(contentsOf: response.list)
            completion(result)
            case .error:
                completion(result)
            }
        }
    }

    func loadNextNewsList(completion: @escaping (NetworkResult<EntriesListResponse>) -> ()) {
        guard let last = loaded.last else {
            completion(.error(NetworkError()))
            return
        }
        let parameters = ListingParameters(limit: 20, after: last.name, rawJson: true)
        apiClient.getTop(parameters: parameters) {
            result in
            switch (result) {
            case .success(let response):
                self.loaded.append(contentsOf: response.list)
                completion(result)
            case .error:
                completion(result)
            }
        }
    }


//    func testItems() -> EntriesListResponse {
//        let string = rawTopResponse
//        guard let data = string.data(using: .utf8) else {
//            fatalError()
//        }
//        let object: [String: Any] = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
//        let data1: [String: Any] = object["data"] as! [String: Any]
//        let array = data1["children"] as! [[String: Any]]
//        let models: [RedditEntryModel] = array.flatMap {
//            guard let postDict = $0["data"] as? NSDictionary else {
//                return nil
//            }
//            return try? RedditEntryModel(map: Map(dictionary: postDict))
//        }
//
//        let response = EntriesListResponse(list: models)
//        return response
//    }
}
