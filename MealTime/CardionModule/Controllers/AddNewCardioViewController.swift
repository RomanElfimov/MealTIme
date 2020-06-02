//
//  AddNewCardioTableViewController.swift
//  MealTime
//
//  Created by Роман Елфимов on 27.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit

class AddNewCardioViewController: UITableViewController {
    
    // MARK: - Properties
    // Свойства для работы с датой
    var myDate: String = ""
    let dateFormatter = DateFormatter()
    
    var currentCardio: CardioModel!
    
    // MARK: - Outlets
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var upperPressureTextField: UITextField!
    @IBOutlet weak var lowerPressureTextField: UITextField!
    @IBOutlet weak var heartRateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarButton.isHidden = true
        
        upperPressureTextField.addTarget(self, action: #selector(dateNotChoose), for: .editingChanged)
        
        setupDateFormatter(dateFormatter: dateFormatter, date: Date())
        dateTextField.text = myDate
        
        setupEditingScreen()
    }
    
    
    // MARK: - Action
    @IBAction func chooseDateButton(_ sender: Any) {
        //Настройка DatePickerView
        let datePicker = DatePickerView.initPicker(delegate: self)
        datePicker.showPickerInController(vc: self)
        
        dateTextField.resignFirstResponder()
        upperPressureTextField.resignFirstResponder()
        lowerPressureTextField.resignFirstResponder()
        heartRateTextField.resignFirstResponder()
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
    
    
    // MARK: - Public Methods
    func getDate() -> String {
        return myDate
    }
    
    func getUpperPressure() -> String {
        guard let upperPressure = upperPressureTextField.text, upperPressure != "" else { return "0" }
        return upperPressure
    }
    
    func getLowerPressure() -> String {
        guard let lowerPressure = lowerPressureTextField.text, lowerPressure != "" else { return "0" }
        return lowerPressure
    }
    
    func getHeartRate() -> String {
        guard let heartRate = heartRateTextField.text, heartRate != "" else { return "0" }
        return heartRate
    }
    
    // Метод позволяет настраивать передаваемый datePicker и устанавливать переданную дату
    func setupDateFormatter(dateFormatter: DateFormatter, date: Date)  {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        myDate = dateFormatter.string(from: date)
        dateTextField.text = myDate
    }
    
    
    //MARK: - Private Methods
    private func setupEditingScreen() {
        // Заполнить текстовые поля сохраненными данными при тапе на ячейку
        if currentCardio != nil {
            dateTextField.text = currentCardio.date
            upperPressureTextField.text = currentCardio.upperPressure
            lowerPressureTextField.text = currentCardio.lowerPressure
            heartRateTextField.text = currentCardio.heartRate
        }
        
        // Настройка navigation bar
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        navigationItem.leftBarButtonItem = nil
        saveButton.isEnabled = true
    }
    
    
}


extension AddNewCardioViewController: UITextFieldDelegate {
    
    // Если на datePicker забыли нажать "Выбрать", устанавливается сегодняшняя дата
    @objc private func dateNotChoose() {
        if upperPressureTextField.becomeFirstResponder() {
            setupDateFormatter(dateFormatter: dateFormatter, date: Date())
        }
    }
}
