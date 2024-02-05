//
//  CustomAlertVC.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import UIKit

class CustomAlertVC: UIViewController {
    
    let containerView = UIView()
    let titleLabel = UILabel(textAlignment: .center, fontSize: 20)
    let messageLabel = UILabel(textAlignment: .center, fontSize: 14)
    let actionButton = UIButton(bgColor: .systemPink)//GUFButton(bgColor: .systemPink)
    
    var alertTitle: String
    var alertMessage: String
    var butttonTitle: String
    
    init(alertTitle: String, alertMessage: String, butttonTitle: String) {
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.butttonTitle = butttonTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubview(containerView)
        containerView.addSubview([
            actionButton,
            titleLabel,
            messageLabel
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureContainerView()
        configureActionButton()
        configureTitleLabel()
        configureMessageLabel()
    }
    
    @objc func dismissAlertVC() {
        self.dismiss(animated: true)
    }
    
    func configureContainerView() {
        
        containerView.pinConstraint(
            trailing: view.safeAreaLayoutGuide.trailingAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor,
            paddingRight: 40, paddingLeft: 40
        )
        containerView.centerView(on: view, axis: .vertical)
        containerView.configureSize(height: 220)
        containerView.borderWidth = 2
        containerView.borderColor = UIColor.white.cgColor
        containerView.cornerRadius = 15
        containerView.backgroundColor = .systemBackground
    }
    
    func configureActionButton() {
        actionButton.pinConstraint(
            trailing: containerView.trailingAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor,
            paddingRight: 20, paddingBottom: 20, paddingLeft: 20
        )
        actionButton.setTitle(butttonTitle, for: .normal)
        actionButton.configureSize(height: 50)
        actionButton.addTarget(self, action: #selector(dismissAlertVC), for: .touchUpInside)
    }
    
    func configureMessageLabel() {
        messageLabel.pinConstraint(
            top: titleLabel.bottomAnchor,
            trailing: containerView.trailingAnchor, bottom: actionButton.topAnchor, leading: containerView.leadingAnchor,
            paddingTop: 10,
            paddingRight: 20, paddingBottom: 10, paddingLeft: 20
        )
        messageLabel.text = alertMessage
        messageLabel.numberOfLines = 0
    }
    
    func configureTitleLabel() {
        titleLabel.pinConstraint(
            top: containerView.topAnchor,
            trailing: containerView.trailingAnchor, leading: containerView.leadingAnchor,
            paddingTop: 20,
            paddingRight: 20, paddingLeft: 20
        )
        titleLabel.configureSize(height: 30)
        titleLabel.text = alertTitle
    }
}
