//
// Created by Alexander Tkachenko on 9/10/17.
//

import UIKit

struct RedditEntryModel {
    let name: String
    let title: String
    let author: String
    let comments: Int
    let created: TimeInterval
    let thumbnail: RedditThumbnailModel
    let image: RedditImageModel

    init(map: Map) throws {
        try name = map.from("name")
        try title = map.from("title")
        try author = map.from("author")
        try comments = map.from("num_comments")
        try created = map.from("created_utc")
        try thumbnail = map.from("")
        try image = map.from("")
    }
}

extension RedditImageModel: Convertible {
    static func fromMap(_ value: Any) throws -> RedditImageModel {
        guard let dict = value as? [String: Any] else {
            throw MappingError.cantConvert(value: value)
        }
        let imageSource: String
        imageSource = (dict["preview"] as? [String: Any]).flatMap {
            return $0["images"] as? [[String: Any]]
        }.flatMap {
            $0.first
        }.flatMap {
            $0["source"] as? [String: Any]
        }.flatMap {
            $0["url"] as? String
        } ?? ""
        return RedditImageModel(url: URL(string: imageSource))
    }

}

extension RedditThumbnailModel: Convertible {
    static func fromMap(_ value: Any) throws -> RedditThumbnailModel {
        guard let dict = value as? [String: Any] else {
            throw MappingError.cantConvert(value: value)
        }
        
        let thumbnailURL: URL? = (dict["thumbnail"] as? String).map({ URL(string: $0)}) ?? nil
        let size: CGSize
        if let width = dict["thumbnail_width"] as? CGFloat,
           let height = dict["thumbnail_height"] as? CGFloat {
            size = CGSize(width: width, height: height)
        }
        else {
            size = .zero
        }
        return RedditThumbnailModel(url: thumbnailURL, size: size)
    }
}
