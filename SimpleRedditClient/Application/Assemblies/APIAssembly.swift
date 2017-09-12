//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

final class APIAssembly {
    lazy var apiClient: RedditAPIClient = {
        return RedditAPIClientImpl(requestBuilder: RequestBuilder())
    }()
}
