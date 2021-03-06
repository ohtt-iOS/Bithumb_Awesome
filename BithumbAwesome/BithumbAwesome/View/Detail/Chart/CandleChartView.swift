//
//  CandleChartView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/05.
//

import SwiftUI
import Charts

struct CandleChartView: UIViewRepresentable {
  var chartData: [Candle]
  var chartType: ChartRadioButtonType
  
  func makeUIView(context: Context) -> CombinedChartView {
    
    let chart = CombinedChartView()
    chart.leftAxis.enabled = false
    chart.xAxis.labelPosition = .bottom
    chart.xAxis.labelCount = 4
    chart.xAxis.labelTextColor = UIColor(Color.aGray3)
    chart.xAxis.gridColor = .clear
    chart.xAxis.axisLineColor = .clear
    
    chart.rightAxis.labelTextColor = UIColor(Color.aGray3)
    chart.rightAxis.gridColor = .clear
    chart.rightAxis.axisLineColor = .clear
    chart.rightAxis.labelPosition = .insideChart
    
    chart.drawOrder = [CombinedChartView.DrawOrder.bar.rawValue,
                       CombinedChartView.DrawOrder.candle.rawValue]
    chart.legend.enabled = false
    chart.autoScaleMinMaxEnabled = true
    return chart
  }
  
  func updateUIView(_ combinedView: CombinedChartView, context _: Context) {
    let combinedData = CombinedChartData()
    let data: [Candle] = chartData
    if !data.isEmpty {
      combinedData.candleData = makeCandleData(data: data)
      combinedData.barData = makeBarData(data: data)
      combinedView.data = combinedData
      combinedView.xAxis.valueFormatter = DateValueFormatter(dates: chartData.compactMap { $0.date },
                                                             type: chartType)
      combinedView.zoom(scaleX: 0, scaleY: 0, x: 0, y: 0)
      let xScale = Double(data.count / 20)
      combinedView.zoom(scaleX: xScale, scaleY: 1, x: 0, y: 0)
      combinedView.moveViewToX(Double(data.count))
    }
  }
  
  private func makeCandleData(data: [Candle]) -> CandleChartData {
    let candleEntries = data.enumerated().compactMap { index, entry -> CandleChartDataEntry in
      guard let highPrice = entry.highPrice,
            let lowPrice = entry.lowPrice,
            let openPrice = entry.openPrice,
            let closePrice = entry.closePrice
      else {
        return CandleChartDataEntry()
      }
      return CandleChartDataEntry(x: Double(index),
                           shadowH: highPrice,
                           shadowL: lowPrice,
                           open: openPrice,
                           close: closePrice)
    }
    let set = CandleChartDataSet(entries: candleEntries)
    set.neutralColor = NSUIColor(Color.aGray1)
    set.decreasingColor = NSUIColor(Color.aBlue1)
    set.increasingColor = NSUIColor(Color.aRed1)
    set.axisDependency = .right
    set.drawValuesEnabled = false
    set.shadowColorSameAsCandle = true
    set.decreasingFilled = true
    set.increasingFilled = true
    return CandleChartData(dataSet: set)
  }
  
  private func makeBarData(data: [Candle]) -> BarChartData {
    let volumeEntries = data.enumerated().compactMap { index, entry -> BarChartDataEntry in
      BarChartDataEntry(x: Double(index),
                        y: entry.volume ?? 0)
    }
    let set = BarChartDataSet(entries: volumeEntries)
    set.axisDependency = .left
    set.drawValuesEnabled = false
    set.setColor(NSUIColor(Color.aGray1))
    return BarChartData(dataSet: set)
  }
}

class DateValueFormatter : IAxisValueFormatter {
  private let dates: [Date]
  private let type: ChartRadioButtonType
  
  init(dates: [Date], type: ChartRadioButtonType) {
    self.dates = dates
    self.type = type
  }
  
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    let index = Int((value / 24) * 24)
    guard index >= 0 && index < dates.count else {
      return ""
    }
    let date = dates[index]
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd"
    
    switch type {
    case .hour_24:
      return "\(dateFormatter.string(from: date))"
    default:
      return "\(timeFormatter.string(from: date))\n\(dateFormatter.string(from: date))"
    }
  }
}


