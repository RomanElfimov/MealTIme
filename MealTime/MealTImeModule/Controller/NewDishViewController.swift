//
//  NewDishTableViewController.swift
//  MealTime
//
//  Created by Роман Елфимов on 15.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit
import RealmSwift

class NewDishViewController: UITableViewController {
    
    // MARK: - Properties
    // Свойства для работы с датой
    var myDate: String = ""
    let dateFormatter = DateFormatter()
    
    // Свойства для редактирования
    var breakfastCurrentObject: BreakfastModel!
    var dinnerCurrentObject: DinnerModel!
    var supperCurrentObject: SupperModel!
    var lunchCurrentObject: LunchModel!
    
    
    // MARK: - Outlets
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dishTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var caloriesTextField: UITextField!
    
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        calendarButton.isHidden = true
        
        dishTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupDateFormatter(dateFormatter: dateFormatter, date: Date())
        dateTextField.text = myDate
        
        setupEditingScreen()
    }
    
    
    // MARK: - Actions
    @IBAction func selectDateButton(_ sender: Any) {
        //Настройка DatePickerView
        let datePicker = DatePickerView.initPicker(delegate: self)
        datePicker.showPickerInController(vc: self)
        
        dishTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
        caloriesTextField.resignFirstResponder()
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
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    
    // MARK: - Public Methods
    // Методы передают информацию из текстовых олей для передачи их в MainVC
    func getDateDish() -> String {
        return myDate
    }
    
    func getDish() -> String {
        guard let dish = dishTextField.text, dish != "" else { return "" }
        return dish
    }
    
    func getWeight() -> String {
        guard let weight = weightTextField.text else { return "" }
        return weight
    }
    
    func getCalories() -> String {
        guard let calories = caloriesTextField.text else { return "" }
        return calories
    }
    
    // Метод позволяет настраивать передаваемый datePicker и устанавливать переданную дату
    func setupDateFormatter(dateFormatter: DateFormatter, date: Date) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        myDate = dateFormatter.string(from: date)
        dateTextField.text = myDate
    }
    
    
    // MARK: - Private Methods
    // Заполняем тектсовые поля информацией с MainVC если хотим отредактирвоать блюдо
    private func setupEditingScreen() {
        
        if breakfastCurrentObject != nil {
            setupNavigationBar(for: breakfastCurrentObject)
            fillTextFields(with: breakfastCurrentObject)
            
        } else if dinnerCurrentObject != nil {
            setupNavigationBar(for: dinnerCurrentObject)
            fillTextFields(with: dinnerCurrentObject)
            
        } else if supperCurrentObject != nil {
            setupNavigationBar(for: supperCurrentObject)
            fillTextFields(with: supperCurrentObject)
            
        } else if lunchCurrentObject != nil {
            setupNavigationBar(for: lunchCurrentObject)
            fillTextFields(with: lunchCurrentObject)
        }
    }
    //Вспомогательный метод для setupEditingScreen - заполняет textField'ы информацией из модели
    private func fillTextFields(with model: AnyObject) {
        dateTextField.text = model.dateDish
        dishTextField.text = model.dish
        weightTextField.text = model.weight
        caloriesTextField.text = model.calories
    }
    
    //Настройка navigationBar при редактировании
    private func setupNavigationBar(for dish: AnyObject) {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = dish.dish
        saveButton.isEnabled = true
    }
    
}


// MARK: - UITextFieldDelegate
extension NewDishViewController: UITextFieldDelegate {
    
    // При нажатии на enter будем переходить к следующему текстовому полю, на последнем убираем клавиатуру
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == dishTextField {
            self.weightTextField.becomeFirstResponder()
        } else if textField == weightTextField {
            self.caloriesTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    // Пока не заполнено название блюда кнопка сохранить не активна
    @objc private func textFieldChanged() {
        if dishTextField.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}
