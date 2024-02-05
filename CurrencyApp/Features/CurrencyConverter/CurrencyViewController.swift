//
//  ViewController.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import RxSwift
import RxCocoa

class CurrencyViewController: UIViewController {

    let conversionView = CurrencyView()
    let viewModel = CurrencyViewModel()
    private let disposeBag = DisposeBag()
    
    var pickerView: UIPickerView?
    var pickerViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        view.addSubview(conversionView)
        viewModel.fetchData()
        listerners()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        conversionView.pin(to: view)
    }
    
    func listerners() {
        // Create an Observable for button taps
        let detailButton = conversionView.bottomView.detailButton
        
        let fromTextField = conversionView.fromTextField
        let toTextField = conversionView.toTextField
        let fromButton = conversionView.fromButton
        let toButton = conversionView.toButton
        let swapButton = conversionView.swapButton
        
        fromTextFieldListener(fromTextField: fromTextField)
        detailButtonListener(detailButton: detailButton)
        fromButtonListener(fromButton: fromButton)
        toButtonListener(toButton: toButton)
        convertedAmountListener(toTextField: toTextField)
        swapAmountListener(swapButton: swapButton,
                           fromButton: fromButton,
                           toButton: toButton,
                           fromTextField: fromTextField,
                           toTextField: toTextField)
        addTapGestureToDismissKeyboard()
        errorListener()
    }
    
    func addTapGestureToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissCurrentKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissCurrentKeyboard() {
        view.endEditing(true)
    }
    
    func fromTextFieldListener(fromTextField: UITextField) {
        let fromTextFieldObservable = fromTextField.rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
                        .distinctUntilChanged()
        fromTextFieldObservable
            .subscribe(onNext: { [self] newAmount in
                // Handle the updated text here
                performConversion()
            })
            .disposed(by: disposeBag)
    }
    
    func detailButtonListener(detailButton: UIButton) {
        detailButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                let destinationVC = DetailViewController()
                destinationVC.modalTransitionStyle = .flipHorizontal
                destinationVC.modalPresentationStyle = .fullScreen
                present(destinationVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func fromButtonListener(fromButton: UIButton) {
        fromButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                print("fromButtonTapObservable tapped!")
                // You can perform any action here
                showCurrencies(button: fromButton)
            })
            .disposed(by: disposeBag)
    }
    
    func toButtonListener(toButton: UIButton) {
        toButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                print("toButtonTapObservable tapped!")
                // You can perform any action here
                showCurrencies(button: toButton)
            })
            .disposed(by: disposeBag)
    }
    
    func convertedAmountListener(toTextField: UITextField) {
        viewModel.convertedAmount
            .subscribe { amount in
                toTextField.text = amount
            }.disposed(by: disposeBag)
    }
    
    func swapAmountListener(swapButton: UIButton,
                            fromButton: UIButton,
                            toButton: UIButton,
                            fromTextField: UITextField,
                            toTextField: UITextField) {
        swapButton.rx
            .tap.subscribe(onNext: { [weak self] in
            guard let self,
                  let from = fromButton.titleLabel?.text,
                  let to = toButton.titleLabel?.text,
                  let fromAmount = fromTextField.text,
                  let toAmount = toTextField.text else {
                return
            }
            viewModel.swapCurrency(from: from, to: to)
            viewModel.swapAmount(fromAmount: fromAmount, toAmount: toAmount)
        })
        .disposed(by: disposeBag)
        
        viewModel.swappedCurrencyValue
            .subscribe { from, to in
                fromButton.setTitle(from, for: .normal)
                toButton.setTitle(to, for: .normal)
            }
            .disposed(by: disposeBag)
        
        viewModel.swappedAmountValue
            .subscribe { fromAmount, toAmount in
                fromTextField.text = fromAmount
                toTextField.text = toAmount
            }
            .disposed(by: disposeBag)
    }
    
    func errorListener() {
        viewModel.errorMessage.subscribe { [weak self] error in
            self?.presentAlertVCMainThread(title: "Error", message: error, buttonTitle: "Dismiss")
        }
        .disposed(by: disposeBag)
    }
    
    func performConversion() {
        guard let fromCurrency = conversionView.fromButton.titleLabel?.text?.prefix(3),
              let toCurrency = conversionView.toButton.titleLabel?.text?.prefix(3),
              let newAmount = conversionView.fromTextField.text,
              !fromCurrency.contains("From") && !toCurrency.contains("To")
        else { return }
        let amount = newAmount.replacingOccurrences(of: ",", with: "")
       viewModel
            .convert(from: "\(fromCurrency)",
                     to: "\(toCurrency)",
                     amount: amount)
    }
    
    func showCurrencies(button: UIButton) {
        pickerView = UIPickerView()
        pickerViewController = UIViewController()
        pickerViewController?.preferredContentSize = CGSize(width: 250, height: 200)
        
        guard let pickerView,
              let pickerViewController else {
            return
        }
        // Bind data source to pickerView
        viewModel.currencies
            .bind(to: pickerView.rx.itemTitles) { _, element in
                return (element.value ?? "") + " " + (element.icon ?? "") // assuming "value" is the property to display in the pickerView
            }
            .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(CurrencyItemInterface.self).subscribe(onNext: { selectedItems in
            guard let selectedItem = selectedItems.first else { return }
            
            let value = selectedItem.value ?? ""
            let icon = selectedItem.icon ?? ""
            
            button.setTitle("\(value) \(icon)", for: .normal)
        })
        .disposed(by: disposeBag)
        
        pickerViewController.view.addSubview(pickerView)
        pickerView.pin(to: pickerViewController.view)
        
        let alertController = UIAlertController(title: "Select Currency", message: nil, preferredStyle: .actionSheet)
        alertController.setValue(pickerViewController, forKey: "contentViewController")
        
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: {_ in
            self.pickerView = nil
            self.pickerViewController = nil
            self.performConversion()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            self.pickerView = nil
            self.pickerViewController = nil
            self.performConversion()
        }))
        
        present(alertController, animated: true, completion: nil)
    }
}




//["UYU": 42.011613, "LTL": 3.172804, "TMT": 3.771597, "JOD": 0.762058, "TTD": 7.296138, "LAK": 22363.097285, "SOS": 613.55588, "ISK": 148.091949, "JMD": 167.717453, "NPR": 142.823823, "CUP": 28.475017, "FKP": 0.850595, "TWD": 33.735378, "BIF": 3067.198937, "THB": 38.500275, "BBD": 2.170014, "LKR": 336.089775, "LBP": 16154.034989, "MRU": 42.65345, "KYD": 0.895695, "GIP": 0.850595, "BMD": 1.074529, "WST": 2.939899, "YER": 269.008251, "HNL": 26.516836, "GTQ": 8.397326, "IQD": 1407.935549, "DJF": 191.360697, "ZAR": 20.428224, "CLF": 0.03728, "FJD": 2.421237, "AOA": 894.561516, "BDT": 117.959197, "MVR": 16.550048, "GBP": 0.856012, "STD": 22240.579519, "KWD": 0.330751, "BTN": 89.264914, "PLN": 4.333251, "JPY": 159.688932, "TOP": 2.548564, "BND": 1.446323, "UGX": 4109.185165, "TZS": 2713.185076, "BHD": 0.405028, "NGN": 1343.706977, "XAG": 0.04828, "KRW": 1434.335175, "BYN": 3.517291, "KMF": 490.52146, "CZK": 25.003978, "VND": 26199.701793, "COP": 4250.675293, "BOB": 7.427051, "PKR": 297.712435, "SRD": 39.353014, "ZMK": 9672.0485, "SGD": 1.447417, "MZN": 68.23392, "DKK": 7.455931, "HUF": 385.63766, "ALL": 104.010688, "BTC": 2.4787444e-05, "MYR": 5.104547, "VEF": 3884406.06478, "HKD": 8.404697, "MOP": 8.659449, "XOF": 655.50797, "GGP": 0.850595, "AFN": 80.314983, "XAF": 655.514066, "IMP": 0.850595, "IRR": 45183.941802, "USD": 1.074529, "CVE": 110.190544, "GMD": 72.450109, "MAD": 10.813743, "CAD": 1.451635, "SEK": 11.375296, "NZD": 1.775338, "LRD": 204.266445, "CHF": 0.934949, "MWK": 1809.294291, "XPF": 119.331742, "BSD": 1.074764, "MXN": 18.479695, "KGS": 96.095397, "ETB": 60.407245, "HTG": 141.44311, "LSL": 19.979695, "UZS": 13267.911342, "OMR": 0.41365, "SHP": 1.357101, "ERN": 16.117934, "AZN": 1.803798, "ZWL": 345.997879, "BAM": 1.954461, "KPW": 967.075753, "CRC": 555.52463, "XAU": 0.000533, "GYD": 224.858062, "SZL": 20.359054, "PHP": 60.572808, "BGN": 1.954004, "EUR": 1.0, "VUV": 127.952896, "TND": 3.360035, "MDL": 19.142244, "MUR": 48.686977, "PAB": 1.074774, "NIO": 39.393015, "MNT": 3655.900682, "PEN": 4.117518, "MMK": 2257.085381, "PYG": 7808.723614, "KES": 176.319268, "SYP": 13970.808273, "SDG": 645.254659, "BWP": 14.723052, "QAR": 3.912328, "AED": 3.94675, "LYD": 5.188446, "SLE": 24.198386, "ANG": 1.936991, "AWG": 1.936838, "TRY": 32.831125, "AUD": 1.656295, "BYR": 21060.767155, "ZMW": 29.153572, "GNF": 9238.671414, "NOK": 11.466086, "TJS": 11.741921, "KZT": 489.55465, "KHR": 4389.034312, "EGP": 33.208425, "BRL": 5.37103, "HRK": 7.393103, "ARS": 890.834064, "MKD": 61.614079, "RON": 4.974101, "UAH": 40.363314, "CUC": 1.074529, "SAR": 4.029671, "NAD": 19.988056, "CLP": 1028.399297, "SBD": 9.053922, "DZD": 144.758975, "RWF": 1365.983356, "DOP": 63.247264, "INR": 89.248815, "MGA": 4869.754807, "VES": 38.887131, "CNY": 7.649038, "CDF": 2947.432615, "XCD": 2.903969, "SLL": 21221.946946, "GEL": 2.863639, "BZD": 2.166416, "RSD": 117.159168, "XDR": 0.806348, "IDR": 16939.303966, "JEP": 0.850595, "RUB": 97.787536, "AMD": 436.609045, "PGK": 4.030295, "SCR": 14.588881, "LVL": 0.649972, "GHS": 13.300137, "ILS": 3.956362]
