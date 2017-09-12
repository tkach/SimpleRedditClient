//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class AppRouter {
    fileprivate let controllersAssembly: ModulesAssembly
    fileprivate lazy var navigationController: UINavigationController = {
        return UINavigationController(rootViewController: self.controllersAssembly.entriesListViewController())
    }()

    init(controllersAssembly: ModulesAssembly) {
        self.controllersAssembly = controllersAssembly
    }

    func rootViewController() -> UIViewController {
        return navigationController
    }
}

extension AppRouter: EntriesListRouter {
    func route(to item: EntryItem) {
        let controller = controllersAssembly.entryDetailsViewController(with: item)
        navigationController.pushViewController(controller, animated: true)
    }
}
