//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class AppRouter {
    fileprivate let controllersAssembly: ModulesAssembly
    fileprivate lazy var navigationController: UINavigationController = {
        return UINavigationController(rootViewController: self.controllersAssembly.newsListViewController())
    }()

    init(controllersAssembly: ModulesAssembly) {
        self.controllersAssembly = controllersAssembly
    }

    func rootViewController() -> UIViewController {
        return navigationController
    }
}

extension AppRouter: NewsListRouter {
    func route(to: NewsItem) {
        let controller = controllersAssembly.newsItemDetailsViewController()
        navigationController.pushViewController(controller, animated: true)
    }
}
