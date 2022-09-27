//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Sarkhan Jafarli on 9/23/22.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {

    let symbol = UIImageView()
    let title = GFTitleLabel(textAlingment: .left, fontSize: 14)
    let count = GFTitleLabel(textAlingment: .center, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(symbol)
        addSubview(title)
        addSubview(count)
        
        symbol.translatesAutoresizingMaskIntoConstraints = false
        symbol.contentMode = .scaleAspectFill
        symbol.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbol.topAnchor.constraint(equalTo: self.topAnchor),
            symbol.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbol.widthAnchor.constraint(equalToConstant: 20),
            symbol.heightAnchor.constraint(equalToConstant: 20),
            
            title.centerYAnchor.constraint(equalTo: symbol.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: symbol.trailingAnchor, constant: 12),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            title.heightAnchor.constraint(equalToConstant: 18),
            
            count.topAnchor.constraint(equalTo: symbol.bottomAnchor, constant: 4),
            count.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            count.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            count.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbol.image = UIImage(systemName: SFSymbols.repos)
            title.text = "Public Repos"
        case .gists:
            symbol.image = UIImage(systemName: SFSymbols.gists)
            title.text = "Public Gists"
        case .followers:
            symbol.image = UIImage(systemName: SFSymbols.followers)
            title.text = "Followers"
        case .following:
            symbol.image = UIImage(systemName: SFSymbols.following)
            title.text = "Following"
        
        }
        
        self.count.text = String(count)
    }
}
