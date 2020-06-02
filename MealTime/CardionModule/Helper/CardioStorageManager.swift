//
//  CardioStorageManager.swift
//  MealTime
//
//  Created by Роман Елфимов on 28.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import Foundation
import RealmSwift

let cardioRealm = try! Realm()

class CardioStorageManager {
    
    static func saveObject(_ object: CardioModel) {
        try! cardioRealm.write {
            cardioRealm.add(object)
        }
    }
    
    static func deleteObject(_ object: CardioModel) {
        try! cardioRealm.write {
            cardioRealm.delete(object)
        }
    }
}
