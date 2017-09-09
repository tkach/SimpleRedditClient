//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

extension NewsItem: CellModel {}

protocol UpdatableCell {
    associatedtype Model: CellModel
    func update(with: Model)
}

final class NewsItemCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var posterView: ImageLoadableView!
    @IBOutlet weak var posterAspect: NSLayoutConstraint!
    
    override var isHighlighted: Bool {
        didSet { contentView.alpha = isHighlighted ? 0.5 : 1 }
    }
}

extension NewsItemCell: UpdatableCell {
    func update(with item: NewsItem) {
        titleLabel.text = item.title
        authorLabel.text = "posted by \(item.author)"
        commentsLabel.text = "\(item.comments) comments"
        
        let url: URL? = item.thumbnailUrlString.map { $0.contains("https") ? URL(string: $0) : nil } ?? nil
//        posterAspect.constant = url != nil ? item.thumbnailImageProportion : 287.0 / 120.0
        print("poster aspect: \(posterAspect.constant)")
        posterView.load(imageURL: url)
    }
}
