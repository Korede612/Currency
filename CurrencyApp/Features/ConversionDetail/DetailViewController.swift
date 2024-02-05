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
    
    var chartView: HistoryChartUIKit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        view.addSubview(dismissButton)
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        rxTableViewDataSource()
        rxTableViewDelegate()
        
        chartView = HistoryChartUIKit()
        if let chartView {
            add(childVC: chartView, to: detailView.topDetailView.stackView)
        }
        
        enableSwipeToDelete()
        // Do any additional setup after loading the view.
        checkAndShowEmptyState()
    }
    
    func checkAndShowEmptyState() {
        if viewModel.getCurrentHistoryData().count == 0 {
            showEmptyStateView(with: "No Data here")
        }
    }
    
    // Add the swipe-to-delete functionality
    private func enableSwipeToDelete() {
        detailView.conversionHistoryTB.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                guard let self else { return }
                viewModel.deleteItem(at: indexPath.row)
                updateChartView()
                viewModel.suggestedData.accept([])
                checkAndShowEmptyState()
                
            })
            .disposed(by: disposeBag)
    }
    
    func updateChartView() {
        if let chartView {
            remove(childVC: chartView, from: detailView.topDetailView.stackView)
        }
        
        chartView = nil
        chartView = HistoryChartUIKit()
        if let chartView {
            add(childVC: chartView, to: detailView.topDetailView.stackView)
        }
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
        
        viewModel.suggestedData.bind(
            to: detailView.suggestionTB.rx.items(
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
                viewModel.convertBaseCurrent(base: item.element?.currencyFlag[0] ?? "EUR",
                                             amount: item.element?.fromAmount ?? "")
            }
            .disposed(by: disposeBag)
        
        detailView.conversionHistoryTB.rx
            .itemSelected
            .subscribe { [weak self] indexPath in
                self?.detailView.conversionHistoryTB.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)
        
        detailView.suggestionTB.rx
            .itemSelected
            .subscribe { [weak self] indexPath in
                self?.detailView.suggestionTB.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
    @objc private func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
