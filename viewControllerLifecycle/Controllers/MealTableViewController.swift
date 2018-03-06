//
//  MealTableViewController.swift
//  viewControllerLifecycle
//
//  Created by Faisal Alkhotaifi on 2/28/18.
//  Copyright © 2018 Faisal Alkhotaifi. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    // MARK: - Properties
    var meals = [Meal]()
    let cellIdentifier = "MealTableViewCell"
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        if let savedMeal = loadMeals(){
            meals += savedMeal
        } else {
            loadSampleMeals()
        }
        
        //Refresh to get new meals
        refresher = UIRefreshControl()
        tableView.addSubview(refresher)
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.tintColor = .red
        refresher.addTarget(self, action: #selector(leadNewMeals), for: .valueChanged)
        
        print("MEAL TABLE VIEW did load ")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.ratingControl.rating = meal.rating
        cell.photoImageView.image = meal.photo
        
        return cell
    }
    
    //Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveMeal()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    // MARK: - Private Methods
    
    private func loadSampleMeals(){
        let photo1 = #imageLiteral(resourceName: "meal")
        let photo2 = #imageLiteral(resourceName: "meal1")
        let photo3 = #imageLiteral(resourceName: "meal2")
        
        guard let mealOne = Meal(name: "Caprese Salad", rating: 4, photo: photo1) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let mealTwo = Meal(name: "Chicken and Potatoes", rating: 5, photo: photo2) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let mealThree = Meal(name: "Pasta with Meatballs", rating: 3, photo: photo3) else {
            fatalError("Unable to instantiate meal3")
        }
        
        meals += [mealOne, mealTwo, mealThree]
    }
    
    @objc private func leadNewMeals(){
        let photo4 = #imageLiteral(resourceName: "meal3")
        let photo5 = #imageLiteral(resourceName: "meal4")
        
        guard let mealFour = Meal(name: "Turkey Sandowish", rating: 4, photo: photo4) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let mealFive = Meal(name: "Chicken and Potatoes", rating: 5, photo: photo5) else {
            fatalError("Unable to instantiate meal2")
        }
        
        meals += [mealFour, mealFive]
        tableView.reloadData()
        refresher.endRefreshing()
    }
    
    private func saveMeal(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        
        if isSuccessfulSave{
            os_log("Meals successfully saved.", log: .default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: .default, type: .error)
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                
                //To update an existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                
                //To add a new meal
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            //save meals
            saveMeal()
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let id = segue.identifier
        
        if id == "ShowDetail" {
            guard let mealDetailViewController = segue.destination as? MealViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        } else if id == "AddItem" {
            os_log("Adding a new meal.", log: .default, type: .debug)
        } else {
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    private func loadMeals() -> [Meal]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }
    
}















