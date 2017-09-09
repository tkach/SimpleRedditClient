//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class ControllersAssembly {
    func newsListViewController() -> UIViewController {
        return NewsListViewController.fromStoryboard()
    }
}
