//
//  DinnerStorageManager.swift
//  MealTime
//
//  Created by Роман Елфимов on 21.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import Foundation
import RealmSwift

let dinnerRealm = try! Realm()

class DinnerStorageManager {
    
    static func saveObject(_ object: DinnerModel) {
        try! dinnerRealm.write {
            dinnerRealm.add(object)
        }
    }
    
    static func deleteObject(_ object: DinnerModel) {
        try! dinnerRealm.write {
            dinnerRealm.delete(object)
        }
    }
}
