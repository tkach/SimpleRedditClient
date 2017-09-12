//
// Created by Alexander Tkachenko on 9/12/17.
// Copyright (c) 2017 Alexander Tkachenko. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case success(response: T)
    case error(NetworkError)
}