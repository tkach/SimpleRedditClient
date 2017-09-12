//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

final class EntriesListServiceImpl {
    fileprivate let apiClient: RedditAPIClient
    fileprivate var lastLoaded: RedditEntryModel?
    fileprivate let pageLimit = 10
    
    init(apiClient: RedditAPIClient) {
        self.apiClient = apiClient
    }
}

extension EntriesListServiceImpl: EntriesListService {
    func loadNextEntries(completion: @escaping (NetworkResult<EntriesListResponse>) -> ()) {
        let last = lastLoaded?.name
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
