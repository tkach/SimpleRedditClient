//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

final class AppAssembly {
    private let apiAssembly: APIAssembly
    let router: AppRouter
    private let controllersAssembly: ControllersAssembly

    init() {
        apiAssembly = APIAssembly()
        controllersAssembly = ControllersAssembly()
        router = AppRouter(controllersAssembly: controllersAssembly)
    }
}
