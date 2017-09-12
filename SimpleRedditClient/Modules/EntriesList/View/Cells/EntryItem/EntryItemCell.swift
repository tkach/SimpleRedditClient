//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

extension EntryItem: CellModel {}

final class EntryItemCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var posterView: ImageLoadableView!
    @IBOutlet weak var posterHeight: NSLayoutConstraint!
    @IBOutlet weak var posterWidth: NSLayoutConstraint!
    
    fileprivate let originalAspect: CGFloat = 0.5

    //injectable from EntriesListDataSource
    var dateFormatter: DateFormatter!

    override func prepareForReuse() {
        super.prepareForReuse()
        posterView.prepareForReuse()
    }
    
    override var isHighlighted: Bool {
        didSet { contentView.alpha = isHighlighted ? 0.5 : 1 }
    }
}

extension EntryItemCell: UpdatableCell {
    func update(with item: EntryItem) {
        titleLabel.text = item.title
        authorLabel.text = formattedAuthor(author: item.author)
        commentsLabel.text = formattedComments(count: item.comments)
        dateLabel.text = formattedDate(date: item.date)

        posterView.load(imageURL: item.thumbnailUrl)
        
        if (item.thumbnailAspect > 0.5) {
            posterWidth.constant = posterHeight.constant * item.thumbnailAspect
        }
        else {
            posterWidth.constant = posterHeight.constant * originalAspect
        }
    }
}

private extension EntryItemCell {
    func formattedAuthor(author: String) -> String {
        let result = "EntryItemCell.PostedBy".localized() + " \(author)"
        return result
    }
    
    func formattedComments(count: Int) -> String {
        let countString = count > 0 ? "\(count) " : ""
        let result = countString + "comments".pluralizedFormat(count)
        return result
    }

    func formattedDate(date: Date) -> String {
        guard let dateFormatter = dateFormatter else { return "9 h ago" }
        let result = dateFormatter.formattedDate(date: date)
        return result
    }
}
