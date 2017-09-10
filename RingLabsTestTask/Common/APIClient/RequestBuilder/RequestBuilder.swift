//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

enum RequestMethod {
    case get
    case post
    func string() -> String {
        switch(self) {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

final class RequestBuilder {
    
    func request(method: RequestMethod, baseURL: String, path: String, parameters: [String: String]) -> URLRequest {
        let urlString = baseURL + "/" + path
        guard var components = URLComponents(string: urlString) else {
            fatalError("Cant create components url \(urlString)")
        }
        var items = [URLQueryItem]()
        for (key,value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        if !items.isEmpty {
            components.queryItems = items
        }
        guard let url = components.url else {
            fatalError("Can't compose request url")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.string()
        return urlRequest
    }
}
