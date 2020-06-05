//
//  WaterViewController.swift
//  MealTime
//
//  Created by Роман Елфимов on 03.06.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit

class WaterViewController: UIViewController {
    
    var currentWeekDay: Int = 0
    var waterProg: Float = 0
    
    var drinkedWater: Float = 0
    var waterGlass: Float = 150
    var allWater: Float = 1500
    
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var waterProgress: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        textForLabelAndProgress()
        
        print("VIEW DID LOAD")
        abc()
    }
    
    
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
        
        textForLabelAndProgress()
    }
    
    
    @IBAction func addWaterButtonTapped(_ sender: Any) {
        
        drinkedWater = waterGlass / allWater
        
        waterProg += drinkedWater
        
        textForLabelAndProgress()
        
        saveWaterProgress(progress: waterProg)
        
        print("addWaterButton \(waterProg * allWater)")
    }
    
    @IBAction func minusWaterButtonTapped(_ sender: Any) {
        waterProg -= drinkedWater
        waterProgress.progress = waterProg
        waterLabel.text = "\(Int(waterProg * allWater)) / \(Int(allWater))"
        
        saveWaterProgress(progress: waterProg)
        print("minusWatterButton \(waterProg * allWater)")
    }
    
    
    // Вызывается в sceneDidBecomeActive
    func abc() {
        
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
            textForLabelAndProgress()
        } else {
            print("else block")
            
            waterProg = getWater()
            print("else block progress \(waterProg)")
            
            //in function
            textForLabelAndProgress()
            
            saveWaterProgress(progress: waterProg)
            waterProg = getWater()
        }
    }
    
    func textForLabelAndProgress() {
        waterProgress.progress = waterProg
        waterLabel.text = "\(Int(waterProg * allWater)) / \(Int(allWater))"
    }
    
    
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
    
}


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
