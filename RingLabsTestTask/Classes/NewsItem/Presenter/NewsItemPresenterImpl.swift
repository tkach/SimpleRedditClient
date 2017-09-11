//
// Created by Alexander Tkachenko on 9/12/17.
//

import Foundation

final class NewsItemPresenterImpl {
    fileprivate unowned let view: NewsItemView
    fileprivate var item: NewsItem
    fileprivate var imageLoader: ImageLoader

    init(view: NewsItemView, item: NewsItem, imageLoader: ImageLoader) {
        self.view = view
        self.item = item
        self.imageLoader = imageLoader
    }
}


extension NewsItemPresenterImpl: NewsItemPresenter {
    func viewLoaded() {
        view.update(title: item.title)
        loadImage()
    }

    func retryButtonTapped() {
        loadImage()
    }
}

private extension NewsItemPresenterImpl {
    func loadImage() {
        if let url = item.originalUrl {
            imageLoader.load(with: url, into: nil) {
                [weak self] result in
                
                switch result {
                case .success(let image):
                    self?.view.didLoad(image: image)
                case .failure(let error):
                    self?.view.didFail(error: error)
                }
            }
        }
    }
}
