//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

final class NewsItemAssembly {
    private let imageLoader: ImageLoader
    
    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
    }
    
    func build(with item: NewsItem) -> UIViewController {
        let controller = NewsItemViewController.fromStoryboard()
        let presenter = NewsItemPresenterImpl(view: controller, item: item, imageLoader: imageLoader)
        controller.presenter = presenter
        return controller
    }
}
