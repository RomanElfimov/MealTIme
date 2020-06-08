//
//  SettingsTableViewController.swift
//  MealTime
//
//  Created by Роман Елфимов on 04.06.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    //MARK: - Properties
    // picker для выбора всего объема воды
    var pickedAllWater: Float = 1500
    var allWaterPickerNamesArray: [String] = ["1500", "1600", "1700", "1800", "1900", "2000", "2000", "2100", "2200", "2300", "2300", "2400", "2500", "2600", "2700", "2800", "2900", "3000", "3100", "3200", "3300", "3400", "3500"]
    
    // picker для выбора объема одного стакана
    var pickedOneGlass: Float = 150
    var oneGlassArray: [String] = ["150", "200", "250", "300", "350", "400", "450", "500"]
    
    //MARK: - Outlets
    @IBOutlet weak var allWaterPicker: UIPickerView!
    @IBOutlet weak var oneGlassPicker: UIPickerView!

    
    //MARK: - Methods
    // Возвращают всю воду и один стакан. Используем в WaterViewController
    func getAllWaterFromPicker() -> Float {
        return pickedAllWater
    }
    
    func getOneGlassFromPicker() -> Float {
        return pickedOneGlass
    }
   
}


//MARK: - Extension UIPickerViewDataSource
extension SettingsTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Количество ячеек
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 {
            return allWaterPickerNamesArray.count
        } else {
            return oneGlassArray.count
        }
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // Названия для ячеек
        if pickerView.tag == 0 {
            return allWaterPickerNamesArray[row]
        } else {
            return oneGlassArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0 {
            pickedAllWater = Float(allWaterPickerNamesArray[row])!
        } else {
            pickedOneGlass = Float(oneGlassArray[row])!
        }
    }    
}
