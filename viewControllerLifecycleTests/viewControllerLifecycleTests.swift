//
//  viewControllerLifecycleTests.swift
//  viewControllerLifecycleTests
//
//  Created by Faisal Alkhotaifi on 2/28/18.
//  Copyright © 2018 Faisal Alkhotaifi. All rights reserved.
//

import XCTest
@testable import viewControllerLifecycle

class viewControllerLifecycleTests: XCTestCase {
    
    //MARK: Meal Class Tests
    
    // Confirm that the Meal initializer returns a Meal object when passed valid parameters.
    func testMealInitializationSucceeds(){
        // Zero rating
        let zeroRatingMeal = Meal(name: "Zero", rating: 0, photo: nil)
        XCTAssertNotNil(zeroRatingMeal)
        
        // Highest positive rating
        let positiveRatingMeal = Meal(name: "Positive", rating: 5, photo: nil)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    // Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
    func testMealInitializationFail(){
        // Negative rating
        let negativeRatingMeal = Meal(name: "Negative", rating: -1, photo: nil)
        XCTAssertNil(negativeRatingMeal)
        
        // Empty String
        let emptyStringMeal = Meal(name: "", rating: 0, photo: nil)
        XCTAssertNil(emptyStringMeal)
        
        // Rating exceeds maximum
        let largeRatingMeal = Meal(name: "Large", rating: 6, photo: nil)
        XCTAssertNil(largeRatingMeal)
    }
    
}
