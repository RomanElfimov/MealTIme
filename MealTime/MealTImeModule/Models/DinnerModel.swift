//
//  DinnerModel.swift
//  MealTime
//
//  Created by Роман Елфимов on 21.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import RealmSwift

class DinnerModel: Object {
    
    @objc dynamic var dateDish: String = ""
    @objc dynamic var dish: String = ""
    @objc dynamic var weight: String?
    @objc dynamic var calories: String?
    
    convenience init(dateDish: String, dish: String, weight: String?, calories: String?) {
        self.init()
        
        self.dateDish = dateDish
        self.dish = dish
        self.weight = weight
        self.calories = calories
    }
}
