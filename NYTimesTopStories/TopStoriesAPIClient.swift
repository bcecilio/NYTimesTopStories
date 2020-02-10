//
//  TopStoriesAPIClient.swift
//  NYTimesTopStoriesTests
//
//  Created by Brendon Cecilio on 2/6/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import Foundation
import NetworkHelper

struct TopStoriesAPIClient {
    static func fetchTopStories(for section: String, completion: @escaping (Result<[Article], AppError>)-> ()) {
        let endpointUrl = "https://api.nytimes.com/svc/topstories/v2/\(section).json?api-key=\(Config.apiKey)"
        guard let url = URL(string: endpointUrl) else {
            completion(.failure(.badURL(endpointUrl)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let topStories = try JSONDecoder().decode(TopStories.self, from: data)
                    completion(.success(topStories.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
