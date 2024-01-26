//
//  ViewController.swift
//  TrendingCoins
//
//  Created by Айтолкун Анарбекова on 24.01.2024.
//

import UIKit
import SnapKit

class CoinListVC: UIViewController {
    
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    var cryptocurrencies: [Cryptocurrency] = []
    var filteredCryptocurrencies: [Cryptocurrency]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Trending Coins"
        view.backgroundColor = UIColor(named: "backColor")
        
        configureTableView()
        configureSearchBar()
        configureNavigationBar()
        fetchData()
        filteredCryptocurrencies = cryptocurrencies
        configureRefreshControl()
        
    }
    
    private func configureRefreshControl() {
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
    
    private func fetchData() {
        NetworkManager.shared.fetchData { [weak self] cryptocurrencies, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            if let cryptocurrencies = cryptocurrencies {
                DispatchQueue.main.async {
                    self.cryptocurrencies = cryptocurrencies
                    self.filteredCryptocurrencies = cryptocurrencies
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func configureTableView() {
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
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.tintColor = .white
        searchBar.searchTextField.textColor = .white
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
    }
    
    @objc private func searchButtonTapped() {
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        navigationItem.rightBarButtonItem = nil
        searchBar.becomeFirstResponder()
    }
    
}

// MARK: - TableView

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
