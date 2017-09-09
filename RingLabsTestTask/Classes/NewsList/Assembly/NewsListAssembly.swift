//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class NewsListAssembly {
    let router: AppRouter
    init(router: AppRouter) {
        self.router = router
    }

    func build() -> UIViewController {
        let controller = NewsListViewController.fromStoryboard()
        let interactor = NewsListInteractorImpl()
        let presenter = NewsListPresenterImpl(view: controller, interactor: interactor, router: router)
        controller.presenter = presenter
        interactor.output = presenter
        return controller
    }
}
