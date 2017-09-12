//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

final class RedditAPIClientImpl {
    let requestBuilder: RequestBuilder

    struct Paths {
        static let baseUrl = "http://www.reddit.com"
        static let topPath = "top.json"
    }

    init() {
        requestBuilder = RequestBuilder()
    }
}

extension RedditAPIClientImpl: RedditAPIClient {
    func getTop(parameters: ListingParameters, completion: @escaping (NetworkResult<EntriesListResponse>) -> ()) {
        let parameters = listingParameters(from: parameters)
        let request = requestBuilder.request(method: .get,
                                             baseURL: Paths.baseUrl,
                                             path: Paths.topPath,
                                             parameters: parameters)
        let mapping = listingResponseMapping

        performRequest(request, mapping: mapping) {
            result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

private extension RedditAPIClientImpl {
    func listingParameters(from parameters: ListingParameters) -> [String: String] {
        var result: [String: String] = [:]
        result["limit"] = "\(parameters.limit)"
        if let after = parameters.after {
            result["after"] = after
        }
        result["raw_json"] = parameters.rawJson ? "1" : "0"
        return result
    }
    
    func listingResponseMapping(json: [String: Any]) -> EntriesListResponse {
        let data1: [String: Any] = json["data"] as! [String: Any]
        let array = data1["children"] as! [[String: Any]]
        let models: [RedditEntryModel] = array.flatMap {
            guard let postDict = $0["data"] as? NSDictionary else {
                return nil
            }
            return try? RedditEntryModel(map: Map(dictionary: postDict))
        }
        let response = EntriesListResponse(list: models)
        return response
    }

    func performRequest<T>(_ request: URLRequest, mapping: @escaping ([String: Any]) -> T, completion:  @escaping (NetworkResult<T>) -> ()) {
        URLSession.shared.dataTask(with: request) {
            (data: Data?, _, error: Error?) -> Void in
            let result = self.parse(data: data, error: error, responseMapping: mapping)
            completion(result)
        }.resume()
    }

    func parse<T>(data: Data?, error: Error?, responseMapping: ([String: Any]) -> T) -> NetworkResult<T> {
        guard let jsonData = data, error == nil else {
            return .error(NetworkError(domain: .requestError))
        }
        let object: Any
        do {
            object = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
        }
        catch {
            return .error(NetworkError(domain: .mappingError))
        }
        if let casted = object as? [String : Any] {
            let response = responseMapping(casted)
            return .success(response: response)
        }
        else {
            return .error(NetworkError(domain: .mappingError))
        }
    }
}
