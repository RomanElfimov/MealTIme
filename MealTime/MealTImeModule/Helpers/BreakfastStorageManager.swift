//
//  BreakfastStorageManager.swift
//  MealTime
//
//  Created by Роман Елфимов on 21.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import Foundation
import RealmSwift

let breakfastRealm = try! Realm()

class BreakfastStorageManager {
    
    static func saveObject(_ object: BreakfastModel) {
        try! breakfastRealm.write {
            breakfastRealm.add(object)
        }
    }
    
    static func deleteObject(_ object: BreakfastModel) {
        try! breakfastRealm.write {
            breakfastRealm.delete(object)
        }
    }
}
