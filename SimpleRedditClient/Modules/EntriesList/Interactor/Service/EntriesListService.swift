//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

struct NetworkError {
    
}

enum NetworkResult<T> {
    case success(response: T)
    case error(NetworkError)
}

protocol EntriesListService {
    func loadNextEntries(completion: @escaping (NetworkResult<EntriesListResponse>) -> ())
}
