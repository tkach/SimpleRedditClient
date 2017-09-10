//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class NewsListAssembly {
    let router: AppRouter
    let apiClient: RedditAPIClient
    init(router: AppRouter, apiClient: RedditAPIClient) {
        self.router = router
        self.apiClient = apiClient
    }

    func build() -> UIViewController {
        let newsListService = NewsListServiceImpl(apiClient: apiClient)
        let controller = NewsListViewController.fromStoryboard()
        let interactor = NewsListInteractorImpl(newsListService: newsListService)
        let presenter = NewsListPresenterImpl(view: controller, interactor: interactor, router: router)
        controller.presenter = presenter
        interactor.output = presenter
        return controller
    }
}
