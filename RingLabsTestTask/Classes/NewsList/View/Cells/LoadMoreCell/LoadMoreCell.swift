//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

final class LoadMoreCell: UICollectionViewCell, UpdatableCell {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func update(with model: LoadMoreModel) {
        switch model.state {
        case .failed:
            errorLabel.isHidden = false
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        case .loading:
            errorLabel.isHidden = true
            activityIndicator.startAnimating()
        case .initial:
            errorLabel.isHidden = true
            activityIndicator.stopAnimating()
        }
    }

    override var isHighlighted: Bool {
        didSet {
            contentView.alpha = isHighlighted ? 0.5 : 1
        }
    }
}
