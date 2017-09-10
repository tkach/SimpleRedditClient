//
//  RedditEntryModelParsingTests.swift
//  RingLabsTestTask
//
//  Created by Alexander Tkachenko on 9/10/17.
//
//

import XCTest

class RedditEntryModelParsingTests: XCTestCase {
    var testJSONString: String!
    var jsonObject: [String: Any]!
    var result: RedditEntryModel!
    
    override func setUp() {
        super.setUp()
        testJSONString = entryJsonString
        guard let data = testJSONString.data(using: .utf8) else {
            fatalError()
        }
        jsonObject = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
        let map = Map(dictionary: jsonObject as NSDictionary)
        result = try! RedditEntryModel(map: map)
    }
    
    
    func testShouldParseTitleCorrectly() {
        XCTAssertEqual(result.title, "I am test title")
    }
    
    func testShouldParseAuthorCorrectly() {
        XCTAssertEqual(result.author, "junglec123")
    }
    
    func testShouldParseCommentsCountCorrectly() {
        XCTAssertEqual(result.comments, 77)
    }
    
    func testShouldParseCreatedCorrectly() {
        XCTAssertEqual(result.created, 1504933674)
    }
    
    func testShouldParseThumbnailCorrectly() {
        let thumbnail = result.thumbnail
        XCTAssertNotNil(thumbnail)
        XCTAssertEqual(thumbnail.url, URL(string: "http://www.google.com"))
        XCTAssertEqual(thumbnail.size.height, 200)
        XCTAssertEqual(thumbnail.size.width, 100)
    }
    
    func testShouldParseImageCorrectly() {
        let image = result.image
        XCTAssertNotNil(image)
        XCTAssertEqual(image.url, URL(string: "http://www.google.com/2"))
    }
}
