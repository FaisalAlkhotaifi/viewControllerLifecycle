//
//  Meal.swift
//  viewControllerLifecycle
//
//  Created by Faisal Alkhotaifi on 2/28/18.
//  Copyright © 2018 Faisal Alkhotaifi. All rights reserved.
//

import UIKit

class Meal{
    //MARK: Properties
    var name: String
    var rating: Int
    var photo: UIImage?
    
    //MARK: Initialization
    init?(name: String, rating: Int, photo: UIImage?) {
        // Initialization should fail if there is no name or if the rating is negative.
        guard !name.isEmpty else {
            return nil
        }
        
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.rating = rating
        self.photo = photo
    }
}
