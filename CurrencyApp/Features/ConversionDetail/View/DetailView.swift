//
//  DetailView.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import UIKit

class DetailView: UIView {
    
    let topDetailView = TopDetailView()
    let bottomDetailView = BottomDetailView()
    let conversionHistoryTB = UITableView()
    let suggestionTB = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview([topDetailView, bottomDetailView])
        bottomDetailView.stackView.addArrangedSubview([conversionHistoryTB, suggestionTB])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
    }
    
    func layoutUI() {
        topDetailView.pinConstraint(top: topAnchor, trailing: trailingAnchor, leading: leadingAnchor)
        bottomDetailView.pinConstraint(trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor)
        topDetailView.configureSizeConstraints(heightConstraint: heightAnchor, heightMultiplier: 0.3)
        bottomDetailView.configureSizeConstraints(heightConstraint: heightAnchor, heightMultiplier: 0.7)
        
        topDetailView.backgroundColor = .orange
        conversionHistoryTB.backgroundColor = .green
        suggestionTB.backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}