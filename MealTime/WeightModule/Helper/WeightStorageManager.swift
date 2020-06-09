//
//  WeightStorageManager.swift
//  MealTime
//
//  Created by Роман Елфимов on 09.06.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import Foundation
import RealmSwift

let weightRealm = try! Realm()

class WeightStorageManager {
    
    static func saveObject(_ object: WeightModel) {
        try! cardioRealm.write {
            weightRealm.add(object)
        }
    }
    
    
    static func deleteObject(_ object: WeightModel) {
        try! weightRealm.write {
            weightRealm.delete(object)
        }
    }
}
