//
//  FlickAPICall.swift
//  CodeChallange
//
//  Created by Abhinay Chary on 4/24/25.
//

import Foundation
import Combine

class FlickrAPIService {
    func searchImages(tags: String) -> AnyPublisher<[FlickrImage], Error> {
        let query = tags.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlStr = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(query)"
        
        guard let url = URL(string: urlStr) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: { output in
                if let json = String(data: output.data, encoding: .utf8) {
                    print("🔍 Raw Flickr JSON:\n\(json)")
                }
            })
            .map(\.data)
            .decode(type: FlickrResponse.self, decoder: {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return decoder
            }())
            .map { $0.items }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
