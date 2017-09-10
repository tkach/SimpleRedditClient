//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class ModulesAssembly {

    let apiClient: RedditAPIClient

    //injectable, please see AppAssembly
    var router: AppRouter!

    init(apiClient: RedditAPIClient) {
        self.apiClient = apiClient
    }

    private lazy var newsListAssembly: NewsListAssembly = {
        NewsListAssembly(router: self.router, apiClient: self.apiClient)
    }()

    private lazy var newsItemAssembly: NewsItemAssembly = {
        NewsItemAssembly()
    }()

    func newsListViewController() -> UIViewController {
        return newsListAssembly.build()
    }

    func newsItemDetailsViewController(with item: NewsItem) -> UIViewController {
        return newsItemAssembly.build(with: item)
    }
}
