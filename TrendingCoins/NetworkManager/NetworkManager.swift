//
//  NetworkManager.swift
//  TrendingCoins
//
//  Created by Айтолкун Анарбекова on 27.01.2024.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(completion: @escaping ([Cryptocurrency]?, Error?) -> Void) {
        let urlString = "https://api.coincap.io/v2/assets"
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let data = json?["data"] as? [[String: Any]] {
                    var cryptocurrencies: [Cryptocurrency] = []
                    for item in data {
                        guard let id = item["id"] as? String,
                              let rankString = item["rank"] as? String,
                              let rank = Int(rankString),
                              let symbol = item["symbol"] as? String,
                              let name = item["name"] as? String,
                              let supplyString = item["supply"] as? String,
                              let supply = Double(supplyString),
                              let marketCapUsdString = item["marketCapUsd"] as? String,
                              let marketCapUsd = Double(marketCapUsdString),
                              let volumeUsd24HrString = item["volumeUsd24Hr"] as? String,
                              let volumeUsd24Hr = Double(volumeUsd24HrString),
                              let priceUsdString = item["priceUsd"] as? String,
                              let priceUsd = Double(priceUsdString),
                              let changePercent24HrString = item["changePercent24Hr"] as? String,
                              let changePercent24Hr = Double(changePercent24HrString),
                              let vwap24HrString = item["vwap24Hr"] as? String,
                              let vwap24Hr = Double(vwap24HrString),
                              let explorer = item["explorer"] as? String else {
                            print("Failed to parse cryptocurrency data")
                            continue
                            
                        }
                        let maxSupply = item["maxSupply"] as? Double
                        let cryptocurrency = Cryptocurrency(id: id, rank: rank, symbol: symbol, name: name, supply: supply, maxSupply: maxSupply, marketCapUsd: marketCapUsd, volumeUsd24Hr: volumeUsd24Hr, priceUsd: priceUsd, changePercent24Hr: changePercent24Hr, vwap24Hr: vwap24Hr, explorer: explorer)
                        cryptocurrencies.append(cryptocurrency)
                    }
                    completion(cryptocurrencies, nil)
                } else {
                    completion(nil, NSError(domain: "Data format is incorrect", code: -1, userInfo: nil))
                }
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                    print("Invalid response")
                    
                }
                if let image = UIImage(data: data) {
                    completion(image)
                }
            }
            
            task.resume()
        }
    
}
