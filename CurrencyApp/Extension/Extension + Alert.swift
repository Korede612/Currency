//
//  Extension + Alert.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import UIKit

extension UIViewController {
    func presentAlertVCMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = CustomAlertVC(
                alertTitle: title,
                alertMessage: message,
                butttonTitle: buttonTitle
            )
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.modalPresentationStyle = .overFullScreen
            self.present(alertVC, animated: true)
        }
    }
}
