//
//  NewsListAssembly.swift
//  RingLabsTestTask
//
//  Created by Alexander Tkachenko on 9/9/17.
//
//

import UIKit

class NewsListViewController: UIViewController {
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
        collectionDataSource = NewsListCollectionDataSource(model: collectionModel)
        collectionDataSource.registerCells(collectionView: collectionView)

        collectionDelegate = NewsListCollectionDelegate(actionsDelegate: self)
        collectionDelegate.model = collectionModel
        
        collectionView.delegate = collectionDelegate
        collectionView.dataSource = collectionDataSource
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionLayout.invalidateLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        rememberCurrentVisibleCell()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    private func rememberCurrentVisibleCell() {
        collectionDelegate.centeredIndexPath = collectionView.indexPathForVisibleItemAtCenter
    }
}

extension NewsListViewController: NewsListView {
    func update(with state: NewsListViewState) {
        switch state {
        case .loading:
            errorView.isHidden = true
            activityIndicator.startAnimating()
        case .failed(let error):
            errorLabel.text = error.text ?? errorLabel.text
            errorView.isHidden = false
            activityIndicator.stopAnimating()
        case .loaded(let model):
            errorView.isHidden = true
            activityIndicator.stopAnimating()
            collectionDataSource.update(with: model)
            collectionView.reloadData()
        case .loadedNext(let model):
            collectionDataSource.update(with: model)
            collectionView.reloadData()
        }
    }
}

extension NewsListViewController: NewsListCollectionActionsDelegate {
    func on(newsItem: NewsItem) {
        presenter.didSelect(item: newsItem)
    }
    
    func onLoadMore() {
        presenter.didScrollToEnd()
        collectionDataSource.onLoadMore()
        collectionView.reloadData()
    }
}
