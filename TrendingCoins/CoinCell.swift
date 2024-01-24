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
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    let coinSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let coinCostLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let coinChangedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .green
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
    func set(coin: Coin) {
        coinImageView.image = coin.image
        coinTitleLabel.text = coin.title
        coinSubtitleLabel.text = coin.subtitle
        coinCostLabel.text = coin.cost
        coinChangedLabel.text = coin.changedCost
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
