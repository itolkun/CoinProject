//
//  AssetDeatilsVC.swift
//  TrendingCoins
//
//  Created by Айтолкун Анарбекова on 26.01.2024.
//

import UIKit

class AssetDeatilsVC: UIViewController {
    
    var coin: Coin?
    
    let coinCost: UILabel = {
        let label = UILabel()
        label.text = "$ 22 678.48"
        label.font = .systemFont(ofSize: 19, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    let coinChangedLabel: UILabel = {
        let label = UILabel()
        label.text = "+100.48(4.32%)"

        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .green
        return label
    }()
    
    let marketCap: UILabel = {
        let label = UILabel()
        label.text = "$518.99"

        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let supply: UILabel = {
        let label = UILabel()
        label.text = "19.38m"

        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let volume: UILabel = {
        let label = UILabel()
        label.text = "$3.52b"

        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
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
        view.backgroundColor = .white
        if let coin = coin?.title {
            title = coin
        }
        
        
        view.addSubview(coinCost)
        view.addSubview(coinChangedLabel)
        
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
        stackView2.addArrangedSubview(supply)
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

        coinChangedLabel.snp.makeConstraints { make in
            make.leading.equalTo(coinCost.snp.trailing).offset(20)
            make.centerY.equalTo(coinCost)
        }
        
        
    }
    
}
