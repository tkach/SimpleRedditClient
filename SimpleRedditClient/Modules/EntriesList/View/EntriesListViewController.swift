//
//  EntriesListAssembly.swift
//  RingLabsTestTask
//
//  Created by Alexander Tkachenko on 9/9/17.
//
//

import UIKit

class EntriesListViewController: UIViewController {
    var presenter: EntriesListPresenter!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var collectionDataSource: EntriesListCollectionDataSource!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    fileprivate var collectionDelegate: EntriesListCollectionDelegate!

    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "EntriesList.Top".localized()
        
        prepareCollectionView()
        presenter.viewLoaded()
    }

    private func prepareCollectionView() {
        let collectionModel = EntriesListCollectionModel()
        collectionDataSource = EntriesListCollectionDataSource(model: collectionModel)
        collectionDataSource.registerCells(collectionView: collectionView)

        collectionDelegate = EntriesListCollectionDelegate(actionsDelegate: self)
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
    
    @IBAction func onRetry(_ sender: Any) {
        presenter.didTapRetryLoading()
    }
    
    private func rememberCurrentVisibleCell() {
        guard isViewLoaded else { return }
        collectionDelegate.centeredIndexPath = collectionView.indexPathForVisibleItemAtCenter
    }
}

extension EntriesListViewController: EntriesListView {
    func didStartLoading() {
        let isFirstLoad = !collectionDataSource.hasData
        if (isFirstLoad) {
            errorView.isHidden = true
            activityIndicator.startAnimating()
        }
        else {
            let indexPath = collectionDataSource.updateLoadMore(state: .loading)
            collectionView.reloadItems(at: [indexPath])
        }
    }

    func didLoad(page: EntriesPage) {
        errorView.isHidden = true
        activityIndicator.stopAnimating()
        let (toDelete, toInsert) = collectionDataSource.append(page: page)
        collectionView.performBatchUpdates({ 
            if (!toDelete.isEmpty) {
                self.collectionView.deleteItems(at: toDelete)
            }
            if (!toInsert.isEmpty) {
                self.collectionView.insertItems(at: toInsert)
            }
        })
    }
    
    func didFailedLoading(error: EntriesListError) {
        errorLabel.text = error.text ?? errorLabel.text
        errorView.isHidden = false
        activityIndicator.stopAnimating()
    }

    func didFailedLoadingMore(error: EntriesListError) {
        let indexPath = collectionDataSource.updateLoadMore(state: .failed)
        collectionView.reloadItems(at: [indexPath])
    }
}

extension EntriesListViewController: EntriesListCollectionActionsDelegate {
    func on(entry: EntryItem) {
        presenter.didSelect(item: entry)
    }
    
    func onLoadMore() {
        presenter.didScrollToEnd()
    }
}
