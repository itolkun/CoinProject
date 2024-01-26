//
//  CoinsTableViewCell.swift
//  TrendingCoins
//
//  Created by Айтолкун Анарбекова on 24.01.2024.
//

import UIKit

class CoinCell: UITableViewCell {
    
    let coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor(named: "iconColor")
        return imageView
    }()
    
    let coinTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let coinSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let coinCostLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let coinChangedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(coinImageView)
        addSubview(coinTitleLabel)
        addSubview(coinSubtitleLabel)
        addSubview(coinCostLabel)
        addSubview(coinChangedLabel)
        
        coinImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        coinTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(coinImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(8)
        }
        
        coinSubtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(coinImageView.snp.trailing).offset(16)
            make.top.equalTo(coinTitleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        coinCostLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
        }
        
        coinChangedLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(coinCostLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func set(coin: Cryptocurrency) {
        
        coinTitleLabel.text = coin.name
        coinSubtitleLabel.text = coin.symbol
        coinCostLabel.text = "$ \(String(format: "%.2f", coin.priceUsd ?? 0.0))"
        if let changePercent = coin.changePercent24Hr {
            let formattedChangePercent = String(format: "%.2f", changePercent)
            
               if changePercent < 0 {
                   coinChangedLabel.text = "\(formattedChangePercent)%"
                   coinChangedLabel.textColor = .red
               } else {
                   coinChangedLabel.text = "+ \(formattedChangePercent)%"
                   coinChangedLabel.textColor = .green
               }
        }
        
        if let symbol = coin.symbol {
            let urlString = "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/32/icon/\(symbol.lowercased()).png"
            
            NetworkManager.shared.downloadImage(from: urlString) { image in
                DispatchQueue.main.async {
                    self.coinImageView.image = image
                }
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
