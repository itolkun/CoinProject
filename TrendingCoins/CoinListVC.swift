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
    var coins: [Coin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Trending Coins"
        coins = fetchData()
        configureTableView()

    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 50
        tableView.register(CoinCell.self, forCellReuseIdentifier: "CoinCell")
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    

}

extension CoinListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell") as! CoinCell
        let coin = coins[indexPath.row]
        cell.set(coin: coin)

        return cell
    }
    
    
}


extension CoinListVC {
    func fetchData() -> [Coin] {
        let coin1 = Coin(image: UIImage(named: "coin")!, title: "Bitcoin", subtitle: "BTS", cost: "1000", changedCost: "8")
        let coin2 = Coin(image: UIImage(named: "coin")!, title: "Bitcoin", subtitle: "BTS", cost: "1000", changedCost: "-6.8")
        let coin3 = Coin(image: UIImage(named: "coin")!, title: "Bitcoin", subtitle: "BTS", cost: "1000", changedCost: "8")
        let coin4 = Coin(image: UIImage(named: "coin")!, title: "Bitcoin", subtitle: "BTS", cost: "1000", changedCost: "+9")
        let coin5 = Coin(image: UIImage(named: "coin")!, title: "Bitcoin", subtitle: "BTS", cost: "1000", changedCost: "8")
        let coin6 = Coin(image: UIImage(named: "coin")!, title: "Bitcoin", subtitle: "BTS", cost: "1000", changedCost: "-3.4")
        let coin7 = Coin(image: UIImage(named: "coin")!, title: "Bitcoin", subtitle: "BTS", cost: "1000", changedCost: "+8")
        return [coin1, coin2, coin3, coin4, coin5, coin6, coin7]
    }
}
