//
//  AddNewWeightTableViewController.swift
//  MealTime
//
//  Created by Роман Елфимов on 08.06.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit

class AddNewWeightTableViewController: UITableViewController {
    
    //MARK: - Properties
    var myDate: String = ""
    let dateFormatter = DateFormatter()
    
    var currentWeight: WeightModel!
    
    //MARK: - Outlets
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var weightTextFIeld: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        calendarButton.isHidden = true
        
        weightTextFIeld.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        dateTextField.text = myDate
        
        setupDateFormatter(dateFormatter: dateFormatter, date: Date())
        setupEditingScreen()
    }
    
    
    //MARK: - Actions
    @IBAction func selectDateButton(_ sender: Any) {
        let datePicker = DatePickerView.initPicker(delegate: self)
        datePicker.showPickerInController(vc: self)
        
        weightTextFIeld.resignFirstResponder()
    }
    
    @IBAction func dateSwitchTapped(_ sender: UISwitch) {
        // Если switch включен, прячем кнопку "выбрать дату"
        if sender.isOn {
            calendarButton.isHidden = true
            setupDateFormatter(dateFormatter: dateFormatter, date: Date())
        } else {
            calendarButton.isHidden = false
            dateTextField.text = ""
            myDate = ""
        }
    }
    
    
    //MARK: - Methods
    func getDate() -> String {
        return myDate
    }
    
    func getWeight() -> String {
        guard let weight = weightTextFIeld.text else { return "0" }
        return weight
    }
    
    func setupDateFormatter(dateFormatter: DateFormatter, date: Date) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        myDate = dateFormatter.string(from: date)
        dateTextField.text = myDate
    }
    
    //MARK: - Private method
    private func setupEditingScreen() {
        // Заполнить текстовые поля сохраненными данными при тапе на ячейку
        if currentWeight != nil {
            dateTextField.text = currentWeight.date
            weightTextFIeld.text = currentWeight.myWeight
        }
        
        // Настройка navigation bar
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        navigationItem.leftBarButtonItem = nil
        saveButton.isEnabled = true
    }
    
    
}


//MARK: - Extension

// Реализуем протокол DatePickerViewDelegate
extension AddNewWeightTableViewController: DatePickerViewDelegate {
    
    func selectDate(datePickerView: DatePickerView, date: Date) {
        setupDateFormatter(dateFormatter: dateFormatter, date: date)
    }
    
    func pushCancel(datePickerView: DatePickerView) { }
}


// MARK: - UITextFieldDelegate
extension AddNewWeightTableViewController: UITextFieldDelegate {
    
    // Пока не заполнено название блюда кнопка сохранить не активна
    @objc private func textFieldChanged() {
        if weightTextFIeld.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}
