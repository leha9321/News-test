//
//  NetworkManager.swift
//  News
//
//  Created by Алексей Трофимов on 05.02.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from urlString: String, with comlition: @escaping ([Article]) -> Void){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                comlition(news.articles)
                
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
        }.resume()
    }
}
