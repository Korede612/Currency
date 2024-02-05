//
//  HistoryChartUIKit.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import SwiftUI
import UIKit

class HistoryChartUIKit: UIViewController {
    @ObservedObject var viewModel = ChartViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swiftUIView = HistoryChart(chartData: $viewModel.data)

        let hostingController = UIHostingController(rootView: swiftUIView)

        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.didMove(toParent: self)
    }
    
}
