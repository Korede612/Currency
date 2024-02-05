//
//  DetailViewController.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import RxSwift

class DetailViewController: UIViewController {

    let dismissButton = UIButton(bgColor: .systemBackground, title: "Back")
    let viewModel = DetailViewModel()
    let detailView = DetailView()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        view.addSubview(dismissButton)
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        rxTableViewDataSource()
        rxTableViewDelegate()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dismissButton.pinConstraint(top: view.topAnchor,
                                    leading: view.leadingAnchor,
                                    paddingTop: 50,
                                    paddingLeft: 20)
        dismissButton.setTitleColor(.black, for: .normal)
        detailView.pin(to: view)
    }
    
    func rxTableViewDataSource() {
        viewModel.data.bind(
            to: detailView.conversionHistoryTB.rx.items(
                cellIdentifier: DetailCell.identifier,
                cellType: DetailCell.self)) { tv, ti, cell in
            cell.configureUI(with: ti)
        }
        .disposed(by: disposeBag)
    }
    
    func rxTableViewDelegate() {
        detailView.conversionHistoryTB
            .rx
            .modelSelected(ConversionHistory.self)
            .subscribe { [weak self] item in
                guard let self else { return }
                print("This item is selected: \(item)")
            }
            .disposed(by: disposeBag)
        
    }
    
    @objc private func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    deinit {
        print("Detail VC is going to sleep")
    }
    
}
