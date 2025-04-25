//
//  FlickrModelTests.swift
//  CodeChallangeTests
//
//  Created by Abhinay Chary on 4/24/25.
//

import XCTest
@testable import CodeChallange

final class FlickrModelTests: XCTestCase {
    
    func testFlickrResponseDecoding() throws {
        let json = """
               {
                   "title": "Recent Uploads tagged porcupine",
                   "link": "https://www.flickr.com/photos/",
                   "description": "",
                   "modified": "2025-04-22T09:37:23Z",
                   "generator": "https://www.flickr.com",
                   "items": [
                       {
                           "title": "DSC2472 - Porcupine",
                           "link": "https://www.flickr.com/photos/sample/12345",
                           "media": {"m": "https://live.staticflickr.com/sample.jpg"},
                           "date_taken": "2025-04-20T18:31:17-08:00",
                           "description": "A cute porcupine photo",
                           "published": "2025-04-22T09:37:23Z",
                           "author": "nobody@flickr.com (\\\"glloydholmes\\\")",
                           "author_id": "160848625@N08",
                           "tags": "porcupine mammal animal nature pasture wildlife nikon field"
                       }
                   ]
               }
               """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let flickrResponse = try decoder.decode(FlickrResponse.self, from: json)
        
        XCTAssertEqual(flickrResponse.title, "Recent Uploads tagged porcupine")
        XCTAssertEqual(flickrResponse.items.count, 1)
        
        let image = flickrResponse.items.first!
        XCTAssertEqual(image.title, "DSC2472 - Porcupine")
        XCTAssertEqual(image.media.m, "https://live.staticflickr.com/sample.jpg")
        XCTAssertEqual(image.tags, "porcupine mammal animal nature pasture wildlife nikon field")
    }
}
