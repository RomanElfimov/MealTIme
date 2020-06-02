//
//  AddNewCardio + DatePickerViewDelegate.swift
//  MealTime
//
//  Created by Роман Елфимов on 28.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import Foundation

// Реализуем протокол DatePickerViewDelegate
extension AddNewCardioViewController: DatePickerViewDelegate {
    
    func selectDate(datePickerView: DatePickerView, date: Date) {
        setupDateFormatter(dateFormatter: dateFormatter, date: date)
    }
    
    func pushCancel(datePickerView: DatePickerView) { }
}
