//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class EntriesListAssembly {
    let router: AppRouter
    let apiClient: RedditAPIClient
    init(router: AppRouter, apiClient: RedditAPIClient) {
        self.router = router
        self.apiClient = apiClient
    }

    func build() -> UIViewController {
        let entriesService = EntriesListServiceImpl(apiClient: apiClient)
        let controller = EntriesListViewController.fromStoryboard()
        let interactor = EntriesListInteractorImpl(entriesListService: entriesService)
        let presenter = EntriesListPresenterImpl(view: controller, interactor: interactor, router: router)
        controller.presenter = presenter
        interactor.output = presenter
        return controller
    }
}
