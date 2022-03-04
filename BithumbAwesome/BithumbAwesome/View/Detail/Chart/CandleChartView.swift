//
//  CandleChartView.swift
//  BithumbAwesome
//
//  Created by ohtt on 2022/03/05.
//

import Charts
import SwiftUI

struct CandleChartView: UIViewRepresentable {
  var chartData: [Candle]
  
  typealias UIViewType = CandleStickChartView
  
  func makeUIView(context: Context) -> CandleStickChartView {
    let chart = CandleStickChartView()
    chart.leftAxis.enabled = false // 왼쪽 축 삭제
    chart.xAxis.labelPosition = .bottom // x축 아래로 세팅
    chart.autoScaleMinMaxEnabled = false
    chart.xAxis.labelCount = 4
    chart.xAxis.labelHeight = 50
    chart.xAxis.labelTextColor = UIColor(Color.aGray3)
    chart.rightAxis.labelTextColor = UIColor(Color.aGray3)
    chart.legend.enabled = false // 범례 삭제
    chart.data = addData()
    return chart
  }
  
  func updateUIView(_ uiView: CandleStickChartView, context: Context) {
    if !chartData.isEmpty {
      uiView.data = addData()
      uiView.xAxis.valueFormatter = DateValueFormatter(dates: chartData.compactMap { $0.date })
      uiView.zoomToCenter(scaleX: 50, scaleY: 10)
      guard let highPrice = chartData.last?.highPrice,
            let lowPrice = chartData.last?.lowPrice else { return }
      uiView.moveViewTo(xValue: Double(chartData.count - 1), yValue: (highPrice + lowPrice) / 2, axis: .right)
    }
  }
  
  func addData() -> CandleChartData {
    let data = CandleChartData()
    var chartEntries = [CandleChartDataEntry]()
    for index in chartData.indices {
      let entry = CandleChartDataEntry(x: Double(index),
                                       shadowH: chartData[index].highPrice ?? 0,
                                       shadowL: chartData[index].lowPrice ?? 0,
                                       open: chartData[index].openPrice ?? 0,
                                       close: chartData[index].closePrice ?? 0)
      chartEntries.append(entry)
    }
    
    let dataSet = CandleChartDataSet(entries: chartEntries)
    dataSet.decreasingColor = NSUIColor(Color.aBlue1)
    dataSet.increasingColor = NSUIColor(Color.aRed1)
    dataSet.neutralColor = NSUIColor(Color.aGray1)
    dataSet.increasingFilled = true
    dataSet.shadowColorSameAsCandle = true
    dataSet.drawValuesEnabled = false
    data.addDataSet(dataSet)
    return data
  }
}


class DateValueFormatter : IAxisValueFormatter {
  private let dates: [Date]
  
  init(dates: [Date]) {
    self.dates = dates
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
    
    return "\(timeFormatter.string(from: date))\n\(dateFormatter.string(from: date))"
  }
}
