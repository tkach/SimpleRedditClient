//
// Created by Alexander Tkachenko on 9/12/17.
//

import UIKit

protocol EntryDetailsView: class {
    func update(title: String)
    func didLoad(image: UIImage)
    func didFail(error: ImageLoadingError)
}
