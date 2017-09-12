//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class AppRouter {
    struct Constants {
        static let rootNavigationRestorationID = "RootNavigationController"
    }
    fileprivate let modulesAssembly: ModulesAssembly
    fileprivate lazy var navigationController: UINavigationController = {
        let controller = UINavigationController(rootViewController: self.modulesAssembly.entriesListViewController())
        controller.restorationIdentifier = Constants.rootNavigationRestorationID
        return controller
    }()

    init(modulesAssembly: ModulesAssembly) {
        self.modulesAssembly = modulesAssembly
    }

    func rootViewController() -> UIViewController {
        return navigationController
    }
    
    func restoreController(with identifier: String, coder: NSCoder) -> UIViewController? {
        if (identifier == Constants.rootNavigationRestorationID) {
            return navigationController
        }
        else {
            return modulesAssembly.restoreController(with: identifier, coder: coder)
        }
    }
}

extension AppRouter: EntriesListRouter {
    func route(to item: EntryItem) {
        let controller = modulesAssembly.entryDetailsViewController(with: item)
        navigationController.pushViewController(controller, animated: true)
    }
}
