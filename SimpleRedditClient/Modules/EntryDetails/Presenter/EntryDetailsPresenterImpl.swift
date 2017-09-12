//
// Created by Alexander Tkachenko on 9/12/17.
//

import Foundation

final class EntryDetailsPresenterImpl {
    fileprivate unowned let view: EntryDetailsView
    fileprivate var item: EntryItem
    fileprivate var imageLoader: ImageLoader

    init(view: EntryDetailsView, item: EntryItem, imageLoader: ImageLoader) {
        self.view = view
        self.item = item
        self.imageLoader = imageLoader
    }
}

extension EntryDetailsPresenterImpl: EntryDetailsPresenter {
    func viewLoaded() {
        view.update(title: item.title)
        loadImage()
    }

    func encodeRestorableState(with coder: NSCoder) {
        EntryItemCoding.encode(item: item, with: coder)
    }

    func retryButtonTapped() {
        loadImage()
    }
}

private extension EntryDetailsPresenterImpl {
    func loadImage() {
        guard let url = item.originalUrl else {
            print("User is not allowed to open entry details for entry without image")
            return
        }
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
