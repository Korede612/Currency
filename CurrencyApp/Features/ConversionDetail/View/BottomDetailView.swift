//
//  BottomDetailView.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import UIKit

class BottomDetailView: UIView {
    
    let headerStackView = UIStackView(distribution: .fillEqually, spacing: 0, axis: .horizontal)
    let stackView = UIStackView(distribution: .fillEqually, spacing: 0, axis: .horizontal)

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview([headerStackView, stackView])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerStackView.pinConstraint(top: topAnchor,
                                      trailing: trailingAnchor,
                                      leading: leadingAnchor,
                                      paddingTop: 0,
                                      paddingRight: 20,
                                      paddingLeft: 20)
        headerStackView.configureSize(height: 40)
        stackView.pinConstraint(top: headerStackView.bottomAnchor,
                                trailing: safeAreaLayoutGuide.trailingAnchor,
                                bottom: safeAreaLayoutGuide.bottomAnchor,
                                leading: safeAreaLayoutGuide.leadingAnchor,
                                paddingTop: 0,
                                paddingRight: 20,
                                paddingBottom: 0,
                                paddingLeft: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
