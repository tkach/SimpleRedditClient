//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

final class NewsListInteractorImpl {
    weak var output: NewsListInteractorOutput?
    
    init() {
    }
}

private var fetchCounts: Int = 0

extension NewsListInteractorImpl: NewsListInteractorInput {
    func fetchNewsList() {
        if (fetchCounts < 2) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.output?.didFail(error: NewsListError(text: "Test failure"))
            }
            fetchCounts += 1
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.output?.didLoad(news: [])
            }
        }
    }
}                  
