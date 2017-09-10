//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

final class NewsItemViewController: UIViewController {
    //injectable
    var newsItem: NewsItem!
    
    @IBOutlet weak var posterView: ImageLoadableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        posterView.load(imageURL: newsItem.originalUrl)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Share",
                style: .plain,
                target: self,
                action: #selector(onShare)
        )
    }

    @objc func onShare() {
        if let image = posterView.imageView.image {
            let vc = UIActivityViewController(activityItems: [image, url],
                                              applicationActivities: nil)
            present(vc, animated: true)
        }
    }
}
