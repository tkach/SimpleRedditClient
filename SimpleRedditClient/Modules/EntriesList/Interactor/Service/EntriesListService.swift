//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

protocol EntriesListService {
    func loadNextEntries(completion: @escaping (NetworkResult<EntriesListResponse>) -> ())
}
