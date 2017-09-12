//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

final class EntryDetailsViewController: UIViewController {
    fileprivate var sharingImage: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var presenter: EntryDetailsPresenter!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }

    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        presenter.encodeRestorableState(with: coder)
    }

    @objc func onShare(item: UIBarButtonItem) {
        guard let image = sharingImage else {
            fatalError("Share bar button item is disabled when image is not loaded")
        }
        let vc = UIActivityViewController(activityItems: [image],
                                          applicationActivities: nil)
        if let popoverController = vc.popoverPresentationController {
            popoverController.barButtonItem = item
            popoverController.permittedArrowDirections = .up
        }
        present(vc, animated: true)
    }

    @IBAction func onRetry(_ sender: Any) {
        activityIndicator.startAnimating()
        errorView.isHidden = true
        presenter.retryButtonTapped()
    }
}

extension EntryDetailsViewController: EntryDetailsView {
    func didLoad(image: UIImage) {
        sharingImage = image
        imageView.image = image
        activityIndicator.stopAnimating()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "EntryItem.Share".localized(),
            style: .plain,
            target: self,
            action: #selector(onShare)
        )
    }

    func update(title: String) {
        self.title = title
    }

    func didFail(error: ImageLoadingError) {
        activityIndicator.stopAnimating()
        errorView.isHidden = false
        errorLabel.text = error.text
    }

}
