//
//  APICaller.swift
//  NewsApiTask
//
//  Created by Илья Петров on 31.10.2021.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()

    
    struct Constants {
        static let topHeadLinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=da2734c8c3484afbb212267e70429941")
        
    }
    
    private init() {}
    
    public func setTopStroires(complection: @escaping(Result<[Articele], Error>) -> Void) {
        guard let url = Constants.topHeadLinesURL else {
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complection(.failure(error))
            }
            else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    complection(.success(result.articles))
                }
                catch {
                    complection(.failure(error))
                }
            }
            
        }
        
        task.resume()
    }
    
    
    
}

//Models

struct APIResponse: Codable {
    let articles: [Articele]
}


struct Articele: Codable {
//    let sourse: Source
    let urlToImage: String
    let title: String
    let description: String
    let url: String
//    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
