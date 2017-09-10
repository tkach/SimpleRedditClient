//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

extension NewsItem: CellModel {}

final class NewsItemCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var posterView: ImageLoadableView!
    @IBOutlet weak var posterHeight: NSLayoutConstraint!
    @IBOutlet weak var posterWidth: NSLayoutConstraint!
    
    let originalAspect: CGFloat = 1

    override func prepareForReuse() {
        super.prepareForReuse()
        posterView.prepareForReuse()
    }
    
    override var isHighlighted: Bool {
        didSet { contentView.alpha = isHighlighted ? 0.5 : 1 }
    }
}

extension NewsItemCell: UpdatableCell {
    func update(with item: NewsItem) {
        titleLabel.text = item.title
        authorLabel.text = "posted by \(item.author)"
        commentsLabel.text = "\(item.comments) comments"
        
        
//        posterAspect.isActive = false
        
//        posterView.removeConstraint(posterAspect)
//        posterAspect = NSLayoutConstraint(item: posterView, attribute: .height, relatedBy: .equal, toItem: posterView, attribute: .width, multiplier: 0.1, constant: 0)
//        posterView.addConstraint(posterAspect)
        
//        let url: URL? = item.thumbnailUrlString.map { $0.contains("https") ? URL(string: $0) : nil } ?? nil
        posterView.load(imageURL: item.thumbnailUrl)
        if (item.thumbnailAspect > 0) {
            posterWidth.constant = posterHeight.constant * item.thumbnailAspect
        }
        else {
            posterWidth.constant = posterHeight.constant * originalAspect
        }
    }
}
