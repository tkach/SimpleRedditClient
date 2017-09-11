//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

final class NewsListServiceImpl {
    fileprivate let apiClient: RedditAPIClient
    fileprivate var lastLoaded: RedditEntryModel?
    fileprivate var pageLimit: Int = 10
    
    init(apiClient: RedditAPIClient) {
        self.apiClient = apiClient
    }
}

extension NewsListServiceImpl: NewsListService {
    func loadNewsList(completion: @escaping (NetworkResult<EntriesListResponse>) -> ()) {
        let parameters = ListingParameters(limit: pageLimit, after: nil, rawJson: true)
        apiClient.getTop(parameters: parameters) {
            result in
            switch result {
            case .success(let response):
                self.lastLoaded = response.list.last
                completion(result)
            case .error:
                completion(result)
            }
        }
    }

    func loadNextNewsList(completion: @escaping (NetworkResult<EntriesListResponse>) -> ()) {
        guard let last = lastLoaded?.name else {
            completion(.error(NetworkError()))
            return
        }
        let parameters = ListingParameters(limit: pageLimit, after: last, rawJson: true)
        apiClient.getTop(parameters: parameters) {
            result in
            switch result {
            case .success(let response):
                self.lastLoaded = response.list.last
                completion(result)
            case .error:
                completion(result)
            }
        }
    }
}
