//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

protocol NewsListPresenter {
    func viewLoaded()
    
    func didSelectPost()
    func didShowLastPost()
    func didTapRetryLoading()
}
