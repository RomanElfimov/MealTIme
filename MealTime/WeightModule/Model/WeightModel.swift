//
//  WeightModel.swift
//  MealTime
//
//  Created by Роман Елфимов on 09.06.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import Foundation
import RealmSwift

class WeightModel: Object {
    
    @objc dynamic var date: String = ""
    @objc dynamic var myWeight: String = ""
    
    convenience init(date: String, weight: String) {
        self.init()
        
        self.date = date
        self.myWeight = weight
    }
}
