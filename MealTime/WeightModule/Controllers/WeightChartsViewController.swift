//
//  WeightChartsViewController.swift
//  MealTime
//
//  Created by Роман Елфимов on 09.06.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit
import RealmSwift
import Charts

class WeightChartsViewController: UIViewController {
    
    //MARK: - Property
    var weightArray: Results<WeightModel>!
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    //MARK: - Outlet
    @IBOutlet weak var weightChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightArray = weightRealm.objects(WeightModel.self)
        weightArray = weightArray.sorted(byKeyPath: "date", ascending: true)
        
        axisFormatDelegate = self
        
        updateWeightChart()
    }
    
    
    //MARK: - Method
    func updateWeightChart() {
        
        var weightDataEntries = [ChartDataEntry]()
        
        for i in 0..<weightArray.count {
            
            // time Interval для оси x
            let df = DateFormatter()
            df.dateStyle = .medium
            df.timeStyle = .short
            df.locale = Locale(identifier: "ru_Ru")
            
            guard let dateInDate = df.date(from: weightArray[i].date) else {
                print("unable to convert date in type Date")
                return
            }
            
            let timeIntervalForDate: TimeInterval = dateInDate.timeIntervalSince1970
            
            guard let weightDuble = Double(weightArray[i].myWeight) else {
                print("unable to convert weight in Double")
                return
            }
            
            
            let weightDataEntry = ChartDataEntry(x: timeIntervalForDate, y: weightDuble)
            weightDataEntries.append(weightDataEntry)
            
            let chartDataSet = LineChartDataSet(entries: weightDataEntries, label: "Вес")
            
            let myWeightData = LineChartData()
            myWeightData.addDataSet(chartDataSet)
            weightChartView.data = myWeightData
            
            // Настраиваем оси
            let xaxis = weightChartView.xAxis
            xaxis.valueFormatter = axisFormatDelegate
            xaxis.labelHeight = 100
            
            // Минимальные значения для левой и правой осей = 0 (чтобы красиво выглядел график)
            let leftAxis = weightChartView.getAxis(.left)
            let rightAxis = weightChartView.getAxis(.right)
            leftAxis.axisMinimum = 0
            rightAxis.axisMinimum = 0
        }
    }
}



//MARK: - Extension
extension WeightChartsViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
    
}
