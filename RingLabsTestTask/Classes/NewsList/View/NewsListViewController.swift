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
        collectionDelegate = NewsListCollectionDelegate(actionsDelegate: self)
        collectionDataSource = NewsListCollectionDataSource(model: collectionModel)
        
        collectionDataSource.registerCell(cell: NewsItemCell.self) {
            collectionView.register($0, forCellWithReuseIdentifier: $1)
        }
        collectionDataSource.registerCell(cell: LoadMoreCell.self) {
            collectionView.register($0, forCellWithReuseIdentifier: $1)
        }
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
        case .loadedNext(let model):
            errorView.isHidden = true
            activityIndicator.isHidden = true
            collectionDataSource.update(with: model)
            collectionView.reloadData()
        }
    }
}

extension NewsListViewController: NewsListCollectionActionsDelegate {
    func on(newsItem: NewsItem) {
        print("on \(newsItem.title)")
    }
    
    func onLoadMore() {
        print("on loadmore")
        presenter.didScrollToEnd()
        collectionDataSource.onLoadMore()
        collectionView.reloadData()
    }
}
