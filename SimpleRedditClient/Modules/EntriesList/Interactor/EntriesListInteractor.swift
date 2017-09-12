//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

protocol EntriesListInteractorInput: class {
    func fetchNextEntries()
}

protocol EntriesListInteractorOutput: class {
    func didLoad(page: EntriesPage)
    func didFail(error: EntriesListError)
    func didFailLoadingNext(error: EntriesListError)
}
