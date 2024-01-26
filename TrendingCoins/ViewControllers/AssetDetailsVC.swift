//
//  AssetDeatilsVC.swift
//  TrendingCoins
//
//  Created by Айтолкун Анарбекова on 26.01.2024.
//

import UIKit

class AssetDetailsVC: UIViewController {
    
    var coin: Cryptocurrency?
    
    let coinCost: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let volumeWeightedAveragelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let coinChangedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let marketCap: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let supplyl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let volume: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let marketCapLabel: UILabel = {
        let label = UILabel()
        label.text = "Market Cap"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let supplyLabel: UILabel = {
        let label = UILabel()
        label.text = "Supply"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let volumeLabel: UILabel = {
        let label = UILabel()
        label.text = "Volume 24Hr"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let stackView = UIStackView()
    let stackView2 = UIStackView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backColor")
        if let coin = coin?.name {
            title = coin
        }
        
        if let priceUsd = coin?.priceUsd {
            coinCost.text = "$ \(String(format: "%.2f", priceUsd))"
        }
        
        
        if let volumeWeightedAverage = coin?.vwap24Hr {
            let formattedvwap = String(format: "%.2f", volumeWeightedAverage)
            
            if coin?.changePercent24Hr ?? 0.0 < 0 {
                volumeWeightedAveragelabel.text = "- \(formattedvwap)"
                volumeWeightedAveragelabel.textColor = .red
            } else {
                volumeWeightedAveragelabel.text = "+ \(formattedvwap)"
                volumeWeightedAveragelabel.textColor = .green
            }
        }
        
        if let changePercent24Hr = coin?.changePercent24Hr {
            let formattedChangePercent = String(format: "%.2f", changePercent24Hr)
            
            if changePercent24Hr < 0 {
                let formattedChangePercent = String(format: "%.2f", abs(changePercent24Hr))
                coinChangedLabel.text = "(\(formattedChangePercent)%)"
                coinChangedLabel.textColor = .red
            } else {
                coinChangedLabel.text = "(\(formattedChangePercent)%)"
                coinChangedLabel.textColor = .green
            }
           }
        
        
        
        
        
           
        if let marketCapUsd = coin?.marketCapUsd {
            let formattedMarketCap: String
            if marketCapUsd >= 1_000_000_000 {
                formattedMarketCap = String(format: "%.2fb", marketCapUsd / 1_000_000_000)
            } else if marketCapUsd >= 1_000_000 {
                formattedMarketCap = String(format: "%.2fm", marketCapUsd / 1_000_000)
            } else {
                formattedMarketCap = String(format: "%.2f", marketCapUsd)
            }
            marketCap.text = "$\(formattedMarketCap)"
        }
           
        if let supply = coin?.supply {
            let formattedSupply: String
            if supply >= 1_000_000_000 {
                formattedSupply = String(format: "%.2fb", supply / 1_000_000_000)
            } else if supply >= 1_000_000 {
                formattedSupply = String(format: "%.2fm", supply / 1_000_000)
            } else {
                formattedSupply = String(format: "%.2f", supply)
            }
            supplyl.text = formattedSupply
        }
           
        if let volumeUsd24Hr = coin?.volumeUsd24Hr {
            let formattedVolume: String
            if volumeUsd24Hr >= 1_000_000_000 {
                formattedVolume = String(format: "%.2fb", volumeUsd24Hr / 1_000_000_000)
            } else if volumeUsd24Hr >= 1_000_000 {
                formattedVolume = String(format: "%.2fm", volumeUsd24Hr / 1_000_000)
            } else {
                formattedVolume = String(format: "%.2f", volumeUsd24Hr)
            }
            volume.text = "$\(formattedVolume)"
        }
        
        
        view.addSubview(coinCost)
        view.addSubview(coinChangedLabel)
        view.addSubview(volumeWeightedAveragelabel)

        
        
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually

        stackView.addArrangedSubview(marketCapLabel)
        stackView.addArrangedSubview(supplyLabel)
        stackView.addArrangedSubview(volumeLabel)
        
        
        stackView2.axis = .horizontal
        stackView2.spacing = 20
        stackView2.alignment = .fill
        stackView2.distribution = .fillEqually

        stackView2.addArrangedSubview(marketCap)
        stackView2.addArrangedSubview(supplyl)
        stackView2.addArrangedSubview(volume)
                
        view.addSubview(stackView)
        view.addSubview(stackView2)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(coinChangedLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        stackView2.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        coinCost.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        volumeWeightedAveragelabel.snp.makeConstraints { make in
            make.leading.equalTo(coinCost.snp.trailing).offset(20)
            make.centerY.equalTo(coinCost)
        }

        coinChangedLabel.snp.makeConstraints { make in
            make.leading.equalTo(volumeWeightedAveragelabel.snp.trailing).offset(5)
            make.centerY.equalTo(volumeWeightedAveragelabel)
        }
        
        
    }
    
}
