//
//  WaterViewController.swift
//  MealTime
//
//  Created by Роман Елфимов on 03.06.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit

class WaterViewController: UIViewController {
    
    //MARK: - Properties
    // Константа помогает определить первый запуск приложения
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    
    //Текущий день недели - используется, когда определяем наступление нового дня
    var currentWeekDay: Int = 0
    
    var waterProg: Float = 0
    var drinkedWater: Float = 0
    var waterGlass: Float = 150
    var allWater: Float = 1500
    

    //MARK: - Outlets
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var waterProgress: UIProgressView!
    

    //MARK: - Actions
    @IBAction func unwind(_ seg: UIStoryboardSegue) {
        guard let settingsVC = seg.source as? SettingsTableViewController else {
            print("Failed to settingsVC")
            return
        }
        
        waterProg = 0
        saveWaterProgress(progress: waterProg)
        
        waterGlass = settingsVC.getOneGlassFromPicker()
        allWater = settingsVC.getAllWaterFromPicker()
        
        saveWaterGlass(waterGlass: waterGlass)
        saveAllWater(allWater: allWater)
        print("SAVING glass: \(waterGlass) and allWater \(allWater)")
        
        textForLabelAndProgress()
    }
    
    // Добавить воду
    @IBAction func addWaterButtonTapped(_ sender: Any) {
        
        drinkedWater = waterGlass / allWater
        
        waterProg += drinkedWater
        
        showWaterAndProgress()
        
        print("addWaterButton \(waterProg * allWater)")
    }
    
    // Убрать воду
    @IBAction func minusWaterButtonTapped(_ sender: Any) {
        drinkedWater = waterGlass / allWater
        
        waterProg -= drinkedWater
        
        showWaterAndProgress()
        
        print("minusWatterButton \(waterProg * allWater)")
    }
    
    
    //MARK: - Methods
    
    // Если наступил новый день - обнуляем прогресс, иначе - прибавляем
    // Вызывается в sceneDidBecomeActive
    func newDayComingCheck() {
        
        let date = Date()
        let calendar = Calendar.current
        
        let weekday = calendar.component(.weekday, from: date)
        currentWeekDay = getCurrentWeekDay()
        print("currentWeekDay \(currentWeekDay) before if")
        
        
        if weekday != currentWeekDay {
            
            currentWeekDay = weekday
            saveCurrentWeekDay(weekDay: currentWeekDay)
            
            waterProg = 0
            waterProgress.progress = waterProg
            waterLabel.text = "0 / \(Int(allWater))"
            saveWaterProgress(progress: waterProg)
            
            print("if block")
            print("in system \(weekday)")
            print("currentWeekDay \(currentWeekDay) after if")
            
            waterProg = getWater()
            //in function
            showWaterAndProgress()
        } else {
            print("else block")
            
            waterProg = getWater()
            print("else block progress \(waterProg)")
            
            //in function
            showWaterAndProgress()
            
            saveWaterProgress(progress: waterProg)
        }
    }
    
    // Обновить прогресс в label и progress view
    func textForLabelAndProgress() {
        waterProgress.progress = waterProg
        waterLabel.text = "\(Int(waterProg * allWater)) / \(Int(allWater))"
    }
    
    
    //MARK: - save data methods
    func saveWaterProgress(progress: Float) {
        UserDefaults.standard.set(progress, forKey: "waterProgress")
        UserDefaults.standard.synchronize()
    }
    
    func saveCurrentWeekDay(weekDay: Int) {
        UserDefaults.standard.set(weekDay, forKey: "weekDay")
        UserDefaults.standard.synchronize()
    }
    
    
    func saveWaterGlass(waterGlass: Float) {
        UserDefaults.standard.set(waterGlass, forKey: "oneGlass")
        UserDefaults.standard.synchronize()
    }
    
    func saveAllWater(allWater: Float) {
        UserDefaults.standard.set(allWater, forKey: "allWater")
        UserDefaults.standard.synchronize()
    }
    
    
    
    //MARK: - get data methods
    func getWater() -> Float {
        return UserDefaults.standard.float(forKey: "waterProgress")
    }
    
    func getCurrentWeekDay() -> Int {
        return UserDefaults.standard.integer(forKey: "weekDay")
    }
    
    
    func getWaterGlass() -> Float {
        return UserDefaults.standard.float(forKey: "oneGlass")
    }
    
    func getAllWater() -> Float {
        return UserDefaults.standard.float(forKey: "allWater")
    }
    
    
    //MARK: - Private Methods
    private func showWaterAndProgress() {
        waterProgress.progress = waterProg
        waterLabel.text = "\(Int(waterProg * allWater)) / \(Int(allWater))"
    }
    
}


//MARK: - Extension UIProgressView
// Высота progress view
extension UIProgressView {
    
    @IBInspectable var barHeight : CGFloat {
        get {
            return transform.d * 2.0
        }
        set {
            // 2.0 Refers to the default height of 2
            let heightScale = newValue / 2.0
            let c = center
            transform = CGAffineTransform(scaleX: 1.0, y: heightScale)
            center = c
        }
    }
}
