//
//  RatingControl.swift
//  viewControllerLifecycle
//
//  Created by Faisal Alkhotaifi on 2/28/18.
//  Copyright © 2018 Faisal Alkhotaifi. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    //MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet{
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{
            setupButton()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet{
            setupButton()
        }
    }
    
    
    //MARK Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    //MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton){
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    //MARK: Private Method
    private func setupButton(){
        // clear any existing buttons
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "ICC_filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "ICC_emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "ICC_highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount {
            let button = UIButton()
            
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates(){
        for (index, button) in ratingButtons.enumerated(){
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
        }
    }

}









