//
//  LineChartsViewController.swift
//  MealTime
//
//  Created by Роман Елфимов on 02.06.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit
import RealmSwift
import Charts

class LineChartsViewController: UIViewController {
    
    var cardioArray: Results<CardioModel>!
    
    // Делегат для преобразования даты в double для оси x
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    // MARK: - Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    // Окна для графиков давления и пульса
    @IBOutlet weak var pressureChartView: LineChartView!
    @IBOutlet weak var heartRateChartView: LineChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardioArray = cardioRealm.objects(CardioModel.self)
        // Сортируем массив для корректного постороения графиков
        cardioArray = cardioArray.sorted(byKeyPath: "date", ascending: true)
        
        axisFormatDelegate = self
        
        updatePressureChart()
        heartRateChartView.isHidden = true
        updateHeartRateChart()
    }
    
    // MARK: - Action
    @IBAction func segmentedContollTapped(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            // Если 0 - показываем давление
            pressureChartView.isHidden = false
            heartRateChartView.isHidden = true
            
            updatePressureChart()
        case 1:
            // Если 1 - показываем пульс
            pressureChartView.isHidden = true
            heartRateChartView.isHidden = false
            
            updateHeartRateChart()
        default:
            print("default segmentedContollTapped")
        }
    }
    
    
    // MARK: - Method
    func updatePressureChart() {

        var pressureDataEntries = [ChartDataEntry]()
        
        for i in 0..<cardioArray.count {
            
            // time Interval для оси x
            let df = DateFormatter()
            df.dateStyle = .medium
            df.timeStyle = .short
            df.locale = Locale(identifier: "ru_Ru")
            
            guard let dateInDate = df.date(from: cardioArray[i].date) else {
                print("unable to convert date in type Date")
                return
            }
            
            let timeIntervalForDate: TimeInterval = dateInDate.timeIntervalSince1970
            
            // Получаем давление из массива моделей
            guard let pressureDouble = Double(cardioArray[i].upperPressure) else {
                print("unable to convert pressure in Double")
                return
            }
            
            let pressureDataEntry = ChartDataEntry(x: timeIntervalForDate, y: pressureDouble)
            pressureDataEntries.append(pressureDataEntry)
                        
            let chartDataSet = LineChartDataSet(entries: pressureDataEntries, label: "Давление")
            
            let myPressureData = LineChartData()
            myPressureData.addDataSet(chartDataSet)
            pressureChartView.data = myPressureData
            
            // Настраиваем оси
            let xaxis = pressureChartView.xAxis
            xaxis.valueFormatter = axisFormatDelegate
            xaxis.labelHeight = 100
            
            // Минимальные значения для левой и правой осей = 0 (чтобы красиво выглядел график)
            let leftAxis = pressureChartView.getAxis(.left)
            let rightAxis = pressureChartView.getAxis(.right)
            leftAxis.axisMinimum = 0
            rightAxis.axisMinimum = 0
            
            // Линии ограничения
            let limitLine = ChartLimitLine(limit: 145, label: "Высокое давление")
            leftAxis.addLimitLine(limitLine)
        }
        
    }
    
    func updateHeartRateChart() {
    
        var heartDataEntries = [ChartDataEntry]()
        
        for i in 0..<cardioArray.count {
            
            // time Interval для оси x
            let df = DateFormatter()
            df.dateStyle = .medium
            df.timeStyle = .short
            df.locale = Locale(identifier: "ru_Ru")
            
            guard let dateInDate = df.date(from: cardioArray[i].date) else {
                print("unable to convert date in type Date")
                return
            }
            
            let timeIntervalForDate: TimeInterval = dateInDate.timeIntervalSince1970
            
            // Получаем давление из массива моделей
            guard let heartRateDouble = Double(cardioArray[i].heartRate) else {
                print("unable to convert heartRate in Double")
                return
            }
            
            let heartDataEntry = ChartDataEntry(x: timeIntervalForDate, y: heartRateDouble)
            heartDataEntries.append(heartDataEntry)
                        
            let chartDataSet = LineChartDataSet(entries: heartDataEntries, label: "Пульс")
            
            let myData = LineChartData()
            myData.addDataSet(chartDataSet)
            heartRateChartView.data = myData
            
            // Настраиваем оси
            let xaxis = heartRateChartView.xAxis
            xaxis.valueFormatter = axisFormatDelegate
            xaxis.labelHeight = 100
            
            // Минимальные значения для левой и правой осей = 0 (чтобы красиво выглядел график)
            let leftAxis = heartRateChartView.getAxis(.left)
            let rightAxis = heartRateChartView.getAxis(.right)
            leftAxis.axisMinimum = 0
            rightAxis.axisMinimum = 0
            
            // Линии ограничения
            let limitLine = ChartLimitLine(limit: 145, label: "Высокий пульс")
            leftAxis.addLimitLine(limitLine)
        }
    }
    
    
}


// MARK: - Extension IAxisValueFormatter

extension LineChartsViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
    
}


/*
 """
 dd.MM
 HH:mm
 """
 */
