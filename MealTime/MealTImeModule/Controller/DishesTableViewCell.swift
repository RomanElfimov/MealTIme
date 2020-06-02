//
//  DishesTableViewCell.swift
//  MealTime
//
//  Created by Роман Елфимов on 15.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit

class DishesTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dishLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    
    // MARK: - Method
    func initCell(with dish: AnyObject) {
        dateLabel.text = dish.dateDish
        dishLabel.text = dish.dish
        guard let weight = dish.weight, weight != "" else { weightLabel.text = ""; return }
        weightLabel.text = "Вес порции: " + weight! + " грамм"
        
        guard let calories = dish.calories, calories != "" else { caloriesLabel.text = ""; return }
        caloriesLabel.text = calories! + " Ккал"
    }

}
