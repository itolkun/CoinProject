//
//  ViewController.swift
//  TrendingCoins
//
//  Created by Айтолкун Анарбекова on 24.01.2024.
//

import UIKit
import SnapKit

class CoinListVC: UIViewController {
    
    private var tableView = UITableView()
    private var isSearchBarVisible = false
    
    
    var cryptocurrencies: [Cryptocurrency] = []
    var filteredCryptocurrencies: [Cryptocurrency]!
    
    var searchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Trending Coins"
        view.backgroundColor = UIColor(named: "backColor")
        
        configureTableView()
        configureSearchController()
        configureNavigationBar()
        fetchData()
        filteredCryptocurrencies = cryptocurrencies
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = .white
        tableView.refreshControl = refreshControl
        
    }
    @objc private func refreshData(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.fetchData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func fetchData() {
        let urlString = "https://api.coincap.io/v2/assets"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON data received:")
                print(jsonString)
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let data = json?["data"] as? [[String: Any]] {
                    var cryptocurrencies: [Cryptocurrency] = []
                    for item in data {
                        // Parse cryptocurrency data
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
                    DispatchQueue.main.async {
                        self?.cryptocurrencies = cryptocurrencies
                        self?.filteredCryptocurrencies = cryptocurrencies
                        self?.tableView.reloadData()
                    }
                } else {
                    print("Data format is incorrect")
                    
                }
            } catch {
                print("Error parsing JSON: \(error)")
                
            }
        }
        
        task.resume()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 50
        tableView.register(CoinCell.self, forCellReuseIdentifier: "CoinCell")
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureSearchController() {
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.tintColor = .white
        searchBar.searchTextField.textColor = .white
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
    }
    
    @objc private func searchButtonTapped() {
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        navigationItem.rightBarButtonItem = nil
        searchBar.becomeFirstResponder()
    }
    
}

extension CoinListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCryptocurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell") as! CoinCell
        cell.backgroundColor = UIColor(named: "backColor")
        let coin = filteredCryptocurrencies[indexPath.row]
        cell.set(coin: coin)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCoin = filteredCryptocurrencies[indexPath.row]
        let detailVC = AssetDetailsVC()
        detailVC.coin = selectedCoin
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}



// MARK: - UISearchBar

extension CoinListVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        searchBar.showsCancelButton = false
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredCryptocurrencies = cryptocurrencies.filter { cryptocurrency in
            let lowercaseSearchText = searchText.lowercased()
            if let id = cryptocurrency.id, let symbol = cryptocurrency.symbol {
                return id.lowercased().contains(lowercaseSearchText) ||
                symbol.lowercased().contains(lowercaseSearchText)
            } else {
                return true
            }
        }
        
        tableView.reloadData()
    }
}
