//
//  TopStory.swift
//  NYTimesTopStoriesTests
//
//  Created by Brendon Cecilio on 2/6/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import Foundation

enum ImageFormat: String {
    case superJumbo = "superJumbo"
    case thumbLarge = "thumbLarge"
    case normal = "Normal"
    case standardThumbnail = "Standard Normal"
}

struct TopStories: Codable, Equatable {
    let section: String
    let lastUpdated: String
    let results: [Article]
    private enum CodingKeys: String, CodingKey {
        case section
        case lastUpdated = "last_updated"
        case results
    }
}
struct Article: Codable, Equatable {
    let section: String
    let title: String
    let abstract: String
    let publishedDate: String
    let multimedia: [Multimedia]
    private enum CodingKeys: String, CodingKey {
        case section
        case title
        case abstract
        case publishedDate = "published_date"
        case multimedia
    }
}
struct Multimedia: Codable, Equatable {
    let url: String
    let format: String // superJumbo + thumbLarge
    let height: Double
    let width: Double
}

extension Article {
    func getArticleImageURL(for imageFormat: ImageFormat) -> String {
        let result = multimedia.filter {$0.format == imageFormat.rawValue} // "thumbLarge" == "thumbLarge"
        guard let multimediaImage = result.first else {
            return ""
        }
        return multimediaImage.url
    }
}
