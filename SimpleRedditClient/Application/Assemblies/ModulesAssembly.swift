//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class ModulesAssembly {
    let apiClient: RedditAPIClient
    let utilsAssembly: UtilsAssembly

    //injectable, please see AppAssembly
    var router: AppRouter!

    init(apiClient: RedditAPIClient, utilsAssembly: UtilsAssembly) {
        self.apiClient = apiClient
        self.utilsAssembly = utilsAssembly
    }

    private lazy var entriesListAssembly: EntriesListAssembly = {
        EntriesListAssembly(router: self.router, apiClient: self.apiClient)
    }()

    private lazy var entryDetailsAssembly: EntryDetailsAssembly = {
        EntryDetailsAssembly(imageLoader: self.utilsAssembly.imageLoader)
    }()

    func entriesListViewController() -> UIViewController {
        return entriesListAssembly.build()
    }

    func entryDetailsViewController(with item: EntryItem) -> UIViewController {
        return entryDetailsAssembly.build(with: item)
    }

    func restoreController(with identifier: String, coder: NSCoder) -> UIViewController? {
        if (identifier == EntriesListViewController.storyboardID()) {
            return entriesListViewController()
        }
        else if identifier == EntryDetailsViewController.storyboardID() {
            return restoreEntryDetailsViewController(with: coder)
        }
        return nil
    }

    private func restoreEntryDetailsViewController(with coder: NSCoder) -> UIViewController {
        return entryDetailsAssembly.build(with: coder)
    }
}
