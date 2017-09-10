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
    }
}
