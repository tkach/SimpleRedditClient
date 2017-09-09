//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

final class AppAssembly {
    private let apiAssembly: APIAssembly
    let router: AppRouter
    private let controllersAssembly: ModulesAssembly
    private (set) var utilsAssembly: UtilsAssembly

    init() {
        apiAssembly = APIAssembly()
        utilsAssembly = UtilsAssembly()

        controllersAssembly = ModulesAssembly()
        router = AppRouter(controllersAssembly: controllersAssembly)
        controllersAssembly.router = router
    }
}
