//
//  Model.swift
//  MealTime
//
//  Created by Роман Елфимов on 27.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import RealmSwift

class CardioModel: Object {
    
    @objc dynamic var date: String = ""
    @objc dynamic var upperPressure: String = ""
    @objc dynamic var lowerPressure: String = ""
    @objc dynamic var heartRate: String = ""
    
    convenience init(date: String, upperPressure: String, lowerPressure: String, heartRate: String) {
        self.init()
        
        self.date = date
        self.upperPressure = upperPressure
        self.lowerPressure = lowerPressure
        self.heartRate = heartRate
    }
}

