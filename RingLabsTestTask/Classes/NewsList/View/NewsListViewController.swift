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

    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }
    
    @IBAction func onRetry(_ sender: Any) {
        presenter.didTapRetryLoading()
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
        case .loaded(_):
            errorView.isHidden = true
            activityIndicator.isHidden = true
        }
    }

}
