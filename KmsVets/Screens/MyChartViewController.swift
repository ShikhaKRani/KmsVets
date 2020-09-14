//
//  MyChartViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 14/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Charts

class MyChartViewController: BaseViewController, ChartViewDelegate {
    
    @IBOutlet weak var _horizontalChartView: HorizontalBarChartView!
    var dataEntries: [BarChartDataEntry] = []

    var y1 : [Double] = []
    var y2 : [Double] = []
    var y3 : [Double] = []
    var y4 : [Double] = []
    var dataArray =  [10,20.5,7,50, 15, 35 , 85, 55,45,60,91,20,25,49,88,90]
    var finalArray  = [[:]]
    var nameArray  = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Horizontal Bar Char"
        setup(barLineChartView: _horizontalChartView)
        self.setupDict()
        self.setUpChart()
          
    }
    
    //logic
    func setupDict() {
        
        let l1value = 100/4
        
        for value in dataArray  {
            
            if (Int(value ) < l1value) {
                y1.append(value)
            }
            
            if (Int(value) < l1value * 2 ) &&  (Int(value ) > l1value) {
                y2.append(value)
            }
            if (Int(value) < l1value * 3 ) &&  (Int(value ) > l1value * 2 ) {
                y3.append(value)
            }
            
            if (Int(value) < l1value * 4 ) &&  (Int(value ) > l1value * 3) {
                y4.append(value)
            }
        }
        
        
        finalArray.append(["\(0) - \(l1value)" : y1.max() ?? 0.0])
        finalArray.append(["\(l1value) - \(l1value*2)" : y2.max() ?? 0.0])
        finalArray.append(["\(l1value*2) - \(l1value*3)" : y3.max() ?? 0.0])
        finalArray.append(["\(l1value*3) - \(l1value*4)" : y4.max() ?? 0.0])
        
        
        self.updateChartDataSet()
        
    }
    
    
    func setUpChart() {
                
        _horizontalChartView.delegate = self
        _horizontalChartView.drawBarShadowEnabled = false
        _horizontalChartView.drawValueAboveBarEnabled = true
        
        _horizontalChartView.maxVisibleCount = 4
        
        let xAxis = _horizontalChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled = false
        xAxis.granularity = 10
        
        let leftAxis = _horizontalChartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawGridLinesEnabled = false
        leftAxis.axisMinimum = 0
        leftAxis.enabled = false

        
        
        let rightAxis = _horizontalChartView.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.drawAxisLineEnabled = false
        rightAxis.axisMinimum = 0
        
        let l = _horizontalChartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formSize = 8
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4

        _horizontalChartView.fitBars = true
        _horizontalChartView.animate(yAxisDuration: 2.5)
    }
    
    func setup(barLineChartView chartView: BarLineChartViewBase) {
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false

        // ChartYAxis *leftAxis = chartView.leftAxis;
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        
        chartView.rightAxis.enabled = false
        
    }
    
    

    func updateChartDataSet() {
        
        let barWidth = 7.0
        let spaceForBar = 10.0

        
        for i in 0..<finalArray.count{
            
            for ( key, value) in finalArray[i] {
                
                print(finalArray[i])
                nameArray.append("\(key)")
                let dataEntry = BarChartDataEntry(x: Double(finalArray.count-i) * spaceForBar, y: value as! Double)
                dataEntries.append(dataEntry)
            }
        }
        
        
        let customFormater = CustomFormatter()
        customFormater.labels = nameArray.reversed()
        
        _horizontalChartView.xAxis.granularity = 0.0
        _horizontalChartView.xAxis.valueFormatter = customFormater
        
        let set1 = BarChartDataSet(entries: dataEntries, label: "DataSet")
        set1.drawIconsEnabled = false
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name:"HelveticaNeue-Light", size:10)!)
        data.barWidth = barWidth
        _horizontalChartView.data = data
        
        
    }
    
    
}


final class CustomFormatter: IndexAxisValueFormatter {
    
    var labels: [String] = []
    
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let count = self.labels.count
        guard let axis = axis, count > 0 else {
            return ""
        }
        
        let factor = axis.axisMaximum / Double(count)
        let index = Int((value / factor).rounded())
        
        if index > 0 && index <= count {
            let indx = index - 1
            return self.labels[indx]
        }
        
        return ""
    }
}
