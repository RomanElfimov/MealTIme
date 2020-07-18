//
//  WeightCell.swift
//  MealTime
//
//  Created by Роман Елфимов on 08.06.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit

class WeightCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    //MARK: - Method
    func initCell(with weight: WeightModel) {
        dateLabel.text = weight.date
        weightLabel.text = weight.myWeight + " кг"
    }
    
}
