//
//  ARMovie.swift
//  AsyncAwaitPOC
//
//  Created by Ashok Rawat on 02/10/22.
import Foundation
import UIKit

struct Movie: Codable, Identifiable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
    }
    
    /*
    init(from decoder: any Decoder) throws {
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            self.id = try container.decode(Int.self, forKey: .id)
            self.title = try container.decode(String.self, forKey: .title)
            self.overview = try container.decode(String.self, forKey: .overview)
            self.posterPath = try container.decode(String.self, forKey: .posterPath)
        } else {
            let context = DecodingError.Context.init(codingPath: decoder.codingPath, debugDescription: "Unable to decode coordinates!")
            throw DecodingError.dataCorrupted(context)
        }
    }
     */
}

extension Movie {
    
    var posterURL: URL? {
        if let url =  URL(string: "https://image.tmdb.org/t/p/w154/\(posterPath)") {
            //URL(string: "https://image.tmdb.org/t/p/w154/5GA3vV1aWWHTSDO5eno8V5zDo8.jpg") {
            //URL(string: "https://image.tmdb.org/t/p/w154/\(posterPath)")
            //URL(string: "http://vi.placeholder.com/80x80")/
            return url
        }
        return nil
    }
    
    // MARK: - Async properties
    
    var posterMovieImage: UIImage {
        get async {
            let ( data, _) = try! await URLSession.shared.data(from: self.posterURL!)
            return UIImage(data: data)!
        }
    }
    
    // MARK: -  async properties that throw
    
    var posterImage: UIImage? {
        get async throws {
            guard let postUrl = self.posterURL else {
                return nil
            }
            return try await getProcessedImage(postUrl)
//            do {
//                let ( data, _) = try await URLSession.shared.data(from: postUrl)
//                return UIImage(data: data)
//            } catch {
//                throw error
//            }
        }
    }
    
    func getProcessedImage(_ url: URL) async throws -> UIImage? {
        let ( data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data) ?? nil
      }
}
