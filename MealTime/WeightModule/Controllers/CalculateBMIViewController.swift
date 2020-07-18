//
//  CalculateBMIViewController.swift
//  MealTime
//
//  Created by Роман Елфимов on 09.06.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit

class CalculateBMIViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        heightTextField.delegate = self
        weightTextField.delegate = self
    }
    
    //MARK: - Action
    @IBAction func calculateButtonTapped(_ sender: Any) {
        
        guard let weight = weightTextField.text, weight != "" else { print(""); return }
        guard let height = heightTextField.text, height != "" else { return }
        
        guard let weightDouble = Double(weight) else { return  }
        guard let heightDouble = Double(height) else { return  }
        
        
        let bmiResult = weightDouble / pow((heightDouble/100), 2)
        
        bmiLabel.text = "ИМТ: \(Int(bmiResult))"
        
        
        if bmiResult <= 16 {
            descriptionLabel.text = "Дефицит массы тела"
            descriptionLabel.textColor = .lightGray
            descriptionLabel.textColor = .lightGray
        } else if bmiResult > 16 && bmiResult <= 18 {
            descriptionLabel.text = "Недостаточная масса тела"
            descriptionLabel.textColor = .label
        } else if bmiResult > 18 && bmiResult <= 25 {
            descriptionLabel.text = "Нормальный вес"
            descriptionLabel.textColor = .label
        } else if bmiResult > 25 && bmiResult <= 30 {
            descriptionLabel.text = "Избыточная масса тела"
            descriptionLabel.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        } else if bmiResult > 30 && bmiResult <= 35 {
            descriptionLabel.text = "Ожирение первой степени"
            descriptionLabel.textColor = .orange
        } else if bmiResult > 35 && bmiResult <= 40 {
            descriptionLabel.text = "Ожирение второй степени"
            descriptionLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        } else if bmiResult > 40 {
            descriptionLabel.text = "Ожирение третьей степени"
            descriptionLabel.textColor = .red
        } else {
            print("unexpected bmiResult")
        }
        
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
}


extension CalculateBMIViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == heightTextField {
            weightTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
