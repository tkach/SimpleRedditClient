//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

final class NewsItemViewController: UIViewController {
    fileprivate var sharingImage: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var presenter: NewsItemPresenter!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }

    @objc func onShare(item: UIBarButtonItem) {
        guard let image = sharingImage else { fatalError("Sharing image should be loaded prior to sharing") }
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

extension NewsItemViewController: NewsItemView {
    func didLoad(image: UIImage) {
        sharingImage = image
        imageView.image = image
        activityIndicator.stopAnimating()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "NewsItem.Share".localized(),
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
