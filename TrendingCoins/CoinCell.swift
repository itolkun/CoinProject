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
        return imageView
    }()
    
    let coinTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    let coinSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let coinCostLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
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
            make.width.height.equalTo(30)
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
            
            coinChangedLabel.textColor = .green
            coinChangedLabel.text = "\(formattedChangePercent)%"
        }
        
        if let symbol = coin.symbol {
            let urlString = "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/32/icon/\(symbol.lowercased()).png"
            
            if let url = URL(string: urlString) {
                let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                    if let error = error {
                        print("Error fetching image: \(error)")
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        print("Invalid response")
                        return
                    }
                    
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.coinImageView.image = image
                        }
                    }
                }
                task.resume()
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
