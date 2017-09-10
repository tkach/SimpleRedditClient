//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class ModulesAssembly {
    //injectable, please see AppAssembly
    var router: AppRouter!

    private lazy var newsListAssembly: NewsListAssembly = {
        NewsListAssembly(router: self.router)
    }()

    private lazy var newsItemAssembly: NewsItemAssembly = {
        NewsItemAssembly()
    }()

    func newsListViewController() -> UIViewController {
        return newsListAssembly.build()
    }

    func newsItemDetailsViewController() -> UIViewController {
        return newsItemAssembly.build()
    }
}
