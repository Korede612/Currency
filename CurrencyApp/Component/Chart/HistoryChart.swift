//
//  HistoryChart.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import SwiftUI
import Charts

struct HistoryChart: View {
    @Binding var chartData: [ConversionHistory]
    var body: some View {
        VStack {
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(chartData, id: \.id) { datum in
                        HStack(spacing: 0) {
                            Chart {
                                BarMark(x: .value("Cuurency", datum.currency[0]), y: .value("Amount", datum.valueCount[0]))
                                    .foregroundStyle(Color(datum.currencyFlag[0]))
                                
                                
                                BarMark(x: .value("Cuurency1", datum.currency[1]), y: .value("Amount", datum.valueCount[1]))
                                    .foregroundStyle(Color(datum.currencyFlag[1]))
                            }
                            .chartXAxis(.hidden)
                        }
                    }
                }
            }
            
            
            Spacer()
        }
    }
}

struct SamplePreviewData {
    static let data: [ConversionHistory] = [
        .init(currency: ["day1", "day1b"], valueCount: [3, 4.5], currencyFlag: ["BTC", "BRL"], date: .now),
        .init(currency: ["day2", "day2b"], valueCount: [10000, 1000], currencyFlag: ["CDF", "CAD"], date: .now),
        .init(currency: ["day3", "day3b"], valueCount: [200, 500], currencyFlag: ["AED", "NGN"], date: .now),
        .init(currency: ["day4", "day4b"], valueCount: [1600, 1000], currencyFlag: ["CDF", "CAD"], date: .now),
        .init(currency: ["da5", "day5b"], valueCount: [2000, 500], currencyFlag: ["CDF", "NGN"], date: .now),
        .init(currency: ["day6", "day6b"], valueCount: [1600, 1000, 0], currencyFlag: ["CDF", "BRL"], date: .now),
        .init(currency: ["day7", "day7b"], valueCount: [2000, 500, 0], currencyFlag: ["CDF", "BSZ"], date: .now),
        .init(currency: ["day8", "day8b"], valueCount: [1600, 1000, 0], currencyFlag: ["CDF", "BTC"], date: .now)
    ]
}


#Preview {
    HistoryChart(chartData: .constant(SamplePreviewData.data))
}
