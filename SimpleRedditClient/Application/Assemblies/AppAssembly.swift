//
// Created by Alexander Tkachenko on 9/9/17.
//

import Foundation

final class AppAssembly {
    private let apiAssembly: APIAssembly
    let router: AppRouter
    private let modulesAssembly: ModulesAssembly
    private (set) var utilsAssembly: UtilsAssembly

    init() {
        apiAssembly = APIAssembly()
        utilsAssembly = UtilsAssembly()

        modulesAssembly = ModulesAssembly(apiClient: apiAssembly.apiClient, utilsAssembly: utilsAssembly)
        router = AppRouter(modulesAssembly: modulesAssembly)
        modulesAssembly.router = router
    }
}
