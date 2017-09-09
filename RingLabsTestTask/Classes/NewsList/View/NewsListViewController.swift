//
//  NewsListAssembly.swift
//  RingLabsTestTask
//
//  Created by Alexander Tkachenko on 9/9/17.
//
//

import UIKit

class NewsListViewController: UIViewController {
    //injectable
    var presenter: NewsListPresenter!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var collectionDataSource: NewsListCollectionDataSource!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    fileprivate var collectionDelegate: NewsListCollectionDelegate!

    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        presenter.viewLoaded()
    }
    
    @IBAction func onRetry(_ sender: Any) {
        presenter.didTapRetryLoading()
    }

    private func prepareCollectionView() {
        let collectionModel = NewsListCollectionModel()
        collectionDelegate = NewsListCollectionDelegate(actionsDelegate: self)
        collectionDataSource = NewsListCollectionDataSource(model: collectionModel)
        collectionDataSource.registerCell(cell: NewsItemCell.self) {
            nib, identifier in
            collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        }
        collectionDelegate.model = collectionModel
//        collectionLayout.estimatedItemSize = CGSize(width: 200, height: 50)
        collectionView.delegate = collectionDelegate
        collectionView.dataSource = collectionDataSource
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionLayout.invalidateLayout()
    }

}

extension NewsListViewController: NewsListView {
    func update(with state: NewsListViewState) {
        switch state {
        case .loading:
            errorView.isHidden = true
            activityIndicator.isHidden = false
        case .failed(let error):
            errorLabel.text = error.text ?? errorLabel.text
            errorView.isHidden = false
            activityIndicator.isHidden = true
        case .loaded(let model):
            errorView.isHidden = true
            activityIndicator.isHidden = true
            collectionDataSource.update(with: model)
            collectionView.reloadData()
        }
    }
}

extension NewsListViewController: NewsListActionsDelegate {
    func on(newsItem: NewsItem) {
        print("on \(newsItem.title)")
    }
}
