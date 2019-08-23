//
//  StorageManager.swift
//  MyPlaces
//
//  Created by Admin on 23/08/2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
     
    static func saveObject(_ place: Place) {
        
        try! realm.write {
            realm.add(place)
        }
        
    }
}


