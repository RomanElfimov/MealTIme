
//
//  SupperStorageManager.swift
//  MealTime
//
//  Created by Роман Елфимов on 21.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import Foundation
import RealmSwift

let supperRealm = try! Realm()

class SupperStorageManager {
    
    static func saveObject(_ object: SupperModel) {
        try! supperRealm.write {
            supperRealm.add(object)
        }
    }

    static func deleteObject(_ object: SupperModel) {
        try! supperRealm.write {
            supperRealm.delete(object)
        }
    }
}
