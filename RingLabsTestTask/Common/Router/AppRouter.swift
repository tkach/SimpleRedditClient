//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class AppRouter {
    private let controllersAssembly: ModulesAssembly
    private lazy var navigationController: UINavigationController = {
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
    
}