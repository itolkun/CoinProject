//
//  AssetDeatilsVC.swift
//  TrendingCoins
//
//  Created by Айтолкун Анарбекова on 26.01.2024.
//

import UIKit

class AssetDetailsVC: UIViewController {
    
    var coin: Cryptocurrency?
    
    
    lazy var coinCost: UILabel = {
        return makeLabel(fontSize: 22, textColor: .white)
    }()

    lazy var volumeWeightedAveragelabel: UILabel = {
        return makeLabel(fontSize: 15, textColor: .white)
    }()

    lazy var coinChangedLabel: UILabel = {
        return makeLabel(fontSize: 15, textColor: .white)
    }()

    lazy var marketCap: UILabel = {
        return makeLabel(fontSize: 16, textColor: .white)
    }()

    lazy var supplyl: UILabel = {
        return makeLabel(fontSize: 16, textColor: .white)
    }()

    lazy var volume: UILabel = {
        return makeLabel(fontSize: 16, textColor: .white)
    }()

    lazy var marketCapLabel: UILabel = {
        return makeLabel(fontSize: 12, textColor: .gray, text: "Market Cap")
    }()

    lazy var supplyLabel: UILabel = {
        return makeLabel(fontSize: 12, textColor: .gray, text: "Supply")
    }()

    lazy var volumeLabel: UILabel = {
        return makeLabel(fontSize: 12, textColor: .gray, text: "Volume 24Hr")
    }()

    let stackView = UIStackView()
    let stackViewTwo = UIStackView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backColor")
        
        title = coin?.name
       
        labelValues()
        
        view.addSubview(coinCost)
        view.addSubview(coinChangedLabel)
        view.addSubview(volumeWeightedAveragelabel)
        view.addSubview(stackView)
        view.addSubview(stackViewTwo)
        
        configureStackView()
        makeConstraints()

    }
    
    private func labelValues() {
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
    }
    
    
    private func makeLabel(fontSize: CGFloat, textColor: UIColor, text: String? = nil) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize, weight: .regular)
        label.textColor = textColor
        label.numberOfLines = 0
        label.text = text
        return label
    }
    
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually

        stackView.addArrangedSubview(marketCapLabel)
        stackView.addArrangedSubview(supplyLabel)
        stackView.addArrangedSubview(volumeLabel)
        
        
        stackViewTwo.axis = .horizontal
        stackViewTwo.spacing = 20
        stackViewTwo.alignment = .fill
        stackViewTwo.distribution = .fillEqually

        stackViewTwo.addArrangedSubview(marketCap)
        stackViewTwo.addArrangedSubview(supplyl)
        stackViewTwo.addArrangedSubview(volume)
    }
    
    
    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(coinChangedLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        stackViewTwo.snp.makeConstraints { make in
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
