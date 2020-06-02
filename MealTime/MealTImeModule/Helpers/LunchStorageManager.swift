//
//  LunchStorageManager.swift
//  MealTime
//
//  Created by Роман Елфимов on 21.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import Foundation
import RealmSwift

let lunchRealm = try! Realm()

class LunchStorageManager {
    
    static func saveObject(_ object: LunchModel) {
        try! lunchRealm.write {
            lunchRealm.add(object)
        }
    }
    
    static func deleteObject(_ object: LunchModel) {
        try! lunchRealm.write {
            lunchRealm.delete(object)
        }
    }
}
