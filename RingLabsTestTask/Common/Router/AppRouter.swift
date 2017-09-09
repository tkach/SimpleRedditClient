//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class AppRouter {
    private let controllersAssembly: ControllersAssembly

    init(controllersAssembly: ControllersAssembly) {
        self.controllersAssembly = controllersAssembly
    }

    func rootViewController() -> UIViewController {
        return controllersAssembly.newsListViewController()
    }
}
