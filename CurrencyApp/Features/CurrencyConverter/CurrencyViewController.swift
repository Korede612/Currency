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
            guard error != "" else { return }
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
        let tempTitle = button.titleLabel?.text ?? ""
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
            button.setTitle(tempTitle, for: .normal)
            self.performConversion()
        }))
        
        present(alertController, animated: true, completion: nil)
    }
}
