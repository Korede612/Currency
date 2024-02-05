//
//  DetailCell.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import UIKit

class DetailCell: UITableViewCell {
    
    static let identifier = "DetailCell"

    let fromLabel = UILabel(textAlignment: .left, fontSize: 12)
    let fromAmountLabel = UILabel(textAlignment: .left, fontSize: 12)
    
    let toLabel = UILabel(textAlignment: .left, fontSize: 12)
    let toAmountLabel = UILabel(textAlignment: .left, fontSize: 12)
    
    let dateLabel = UILabel(textAlignment: .left, fontSize: 12)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview([fromLabel, fromAmountLabel, toLabel, toAmountLabel, dateLabel])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
    }
    
    func configureUI(with historyData: ConversionHistory) {
        fromLabel.text = "From \(historyData.fromFlag): "
        toLabel.text = "To \(historyData.toFlag): "
        fromAmountLabel.text = historyData.fromAmount
        toAmountLabel.text = historyData.toAmount
        dateLabel.text = historyData.date.formatRelativeDate()
    }
    
    func layoutUI() {
        layoutFromLabel()
        layoutFromAmountLabel()
        layoutToLabel()
        layoutToAmountLabel()
        layoutDateLabel()
    }
    
    func layoutFromLabel() {
        fromLabel.pinConstraint(top: topAnchor, 
                                leading: leadingAnchor,
                                paddingTop: 5)
        fromLabel.configureSize(width: 80, height: 20)
    }
    
    func layoutFromAmountLabel() {
        fromAmountLabel.pinConstraint(top: fromLabel.topAnchor,
                                      trailing: trailingAnchor,
                                      bottom: fromLabel.bottomAnchor,
                                      leading: fromLabel.trailingAnchor,
                                      paddingRight: 5,
                                      paddingLeft: 5)
    }
    
    func layoutToLabel() {
        toLabel.pinConstraint(top: fromLabel.bottomAnchor, 
                              leading: fromLabel.leadingAnchor,
                              paddingTop: 5)
        toLabel.configureSize(width: 80, height: 20)
    }
    
    func layoutToAmountLabel() {
        toAmountLabel.pinConstraint(top: toLabel.topAnchor,
                                    trailing: trailingAnchor,
                                    bottom: toLabel.bottomAnchor,
                                    leading: toLabel.trailingAnchor,
                                    paddingRight: 5,
                                    paddingLeft: 5)
    }
    
    func layoutDateLabel() {
        dateLabel.pinConstraint(top: toLabel.bottomAnchor,
                                trailing: trailingAnchor,
                                bottom: bottomAnchor,
                                leading: leadingAnchor,
                                paddingTop: 5,
                                paddingRight: 5,
                                paddingBottom: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
