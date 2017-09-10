//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

final class NewsItemAssembly {
    func build() -> UIViewController {
        let controller = NewsItemViewController.fromStoryboard()
//        let interactor = NewsListInteractorImpl()
//        let presenter = NewsListPresenterImpl(view: controller, interactor: interactor, router: router)
//        controller.presenter = presenter
//        interactor.output = presenter
        return controller
    }
}
