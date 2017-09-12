//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

final class EntryDetailsAssembly {
    private let imageLoader: ImageLoader
    
    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
    }

    func build(with coder: NSCoder) -> UIViewController {
        let item = EntryItemCoding.entryItem(with: coder)
        return build(with: item)
    }

    func build(with item: EntryItem) -> UIViewController {
        let controller = EntryDetailsViewController.fromStoryboard()
        let presenter = EntryDetailsPresenterImpl(view: controller, item: item, imageLoader: imageLoader)
        controller.presenter = presenter
        return controller
    }
}
