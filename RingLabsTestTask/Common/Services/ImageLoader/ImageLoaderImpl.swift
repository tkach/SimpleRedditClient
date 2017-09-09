//
// Created by Alexander Tkachenko on 9/9/17.
//

import UIKit

final class ImageLoaderImpl {
    
}

extension ImageLoaderImpl: ImageLoader {
    func load(with url: URL, into: ImageTarget? = nil, completion: @escaping (ImageLoadingResult) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    completion(.success(image))
                }
                else {
                    completion(.failure)
                }
            }
        }.resume()

    }
}
