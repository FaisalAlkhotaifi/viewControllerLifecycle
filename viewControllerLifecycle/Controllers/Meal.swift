//
//  Meal.swift
//  viewControllerLifecycle
//
//  Created by Faisal Alkhotaifi on 2/28/18.
//  Copyright © 2018 Faisal Alkhotaifi. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding{
    
    //MARK: Properties
    
    var name: String
    var rating: Int
    var photo: UIImage?
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
    
    struct PropertyKey {
        //The static keyword indicates that these constants belong to the structure itself, not to instances of the structure.
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
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
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else{
            os_log("Unable to decode the name for a Meal object.", log: .default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        //Because the return value of decodeIntegerForKey is Int, there’s no need to downcast the decoded value and there is no optional to unwrap.
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        self.init(name: name, rating: rating, photo: photo)
    }
    
}
