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

protocol NewsListService {
    func loadNewsList(completion: @escaping (NetworkResult<EntriesListResponse>) -> ())
    func loadNextNewsList(completion: @escaping (NetworkResult<EntriesListResponse>) -> ())
}