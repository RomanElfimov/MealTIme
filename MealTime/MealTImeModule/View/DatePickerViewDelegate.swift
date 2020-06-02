//
//  DatePickerViewDelegate.swift
//  MealTime
//
//  Created by Роман Елфимов on 18.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import Foundation

// Протокол объявляет функции для кнопок Отмена и Добавить на DatePicker. Реализованы они в NewDishTableViewController
protocol DatePickerViewDelegate {
    
    func selectDate(datePickerView: DatePickerView, date: Date)
    func pushCancel(datePickerView: DatePickerView)
}
