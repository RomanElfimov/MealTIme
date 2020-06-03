//
//  CardioTableViewCell.swift
//  MealTime
//
//  Created by Роман Елфимов on 27.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit

class CardioCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var heartRateLabel: UILabel!
   
    @IBOutlet weak var warningPressureLabel: UILabel!
    @IBOutlet weak var warningHeartRateLabel: UILabel!
    
    func initCell(with cardio: CardioModel) {
        
        dateLabel.text = cardio.date
        
        // Устанавливаем цвет ярлыка пульса
        guard let heartRateInt = Int(cardio.heartRate) else {
            cardio.heartRate = "0"
            return
        }
        
        if heartRateInt < 60 {
            heartRateLabel.textColor = .lightGray
            warningHeartRateLabel.text = "Низкий пульс"
        } else if heartRateInt >= 60 && heartRateInt <= 80 {
            heartRateLabel.textColor = .label
            warningHeartRateLabel.text = "Пульс в норме"
        } else if heartRateInt > 80 && heartRateInt <= 120 {
            heartRateLabel.textColor = .orange
            warningHeartRateLabel.text = "Повышенные пульс"
            warningHeartRateLabel.textColor = .orange
        } else if heartRateInt > 120 {
            heartRateLabel.textColor = .red
            warningHeartRateLabel.text = "! Обратите внимание на пульс, если вы не занимались спортом недавно"
            warningHeartRateLabel.textColor = .red
        }
        
        
        // Устанавливаем цвет ярлыка давления
        guard let upperPressureInt = Int(cardio.upperPressure) else {
            cardio.upperPressure = "0"
            return
        }
        
        if upperPressureInt < 100 {
            pressureLabel.textColor = .lightGray
            warningPressureLabel.text = "Низкое давление"
        } else if upperPressureInt >= 100 && upperPressureInt <= 130 {
            pressureLabel.textColor = .label
            warningPressureLabel.text = "Давление в норме"
        } else if upperPressureInt > 130 && upperPressureInt <= 145 {
            pressureLabel.textColor = .orange
            warningPressureLabel.text = "Повышенное давление"
            warningPressureLabel.textColor = .orange
        } else if upperPressureInt > 145 {
            pressureLabel.textColor = .red
            warningPressureLabel.text = "! Обратите внимание на давление"
            warningPressureLabel.textColor = .red
        }
        
        
        // Устанавливаем красивые значения если к/л значение осталось пустым. Нельзя сделать это в установке цвета, т.к. при редактировании на граничные значения цвет не будет меняться
        if heartRateInt == 0 {
            heartRateLabel.text = "Пульс -/-"
        } else {
            heartRateLabel.text =  "Пульс \(cardio.heartRate)"
        }
        
        if upperPressureInt == 0{
            pressureLabel.text = "Давление -/- "
        } else {
            pressureLabel.text = "Давление \(cardio.upperPressure)  /  \(cardio.lowerPressure)"
        }
    }
    
}
