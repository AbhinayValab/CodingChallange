//
//  FlickrModel.swift
//  CodeChallange
//
//  Created by Abhinay Chary on 4/24/25.
//

import Foundation

struct FlickrResponse: Decodable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [FlickrImage]
}

struct FlickrImage: Decodable, Identifiable {
    var id: String { link }

    let title: String
    let link: String
    let media: Media
    let dateTaken: String?
    let description: String
    let published: String
    let author: String
    let authorId: String?
    let tags: String

    enum CodingKeys: String, CodingKey {
        case title, link, media, description, published, author, tags
        case dateTaken = "date_taken"
        case authorId = "author_id"
    }
}

struct Media: Decodable {
    let m: String
}
