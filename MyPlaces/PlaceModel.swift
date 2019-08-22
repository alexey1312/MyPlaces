//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Admin on 22/08/2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import UIKit

struct Place {
    
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var restaurantImage: String?
    
    static let restaurantNames = [
        "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
        "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
        "Speak Easy", "Morris Pub", "Вкусные истории",
        "Классик", "Love&Life", "Шок", "Бочка"
    ]
    
    static func getPlace() -> [Place] {
        
        var places = [Place]()
        
        for place in restaurantNames {
            places.append(Place(name: place, location: "Красноясрк", type: "Ресторан", image: nil, restaurantImage: place))
        }
        
        return places
        
    }
}

