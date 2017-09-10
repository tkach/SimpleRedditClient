//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

protocol RedditAPIClient {
    func getTop(parameters: ListingParameters, completion: @escaping (NetworkResult<EntriesListResponse>) -> ())
}
