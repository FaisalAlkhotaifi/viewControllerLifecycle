//
//  ViewController.swift
//  viewControllerLifecycle
//
//  Created by Faisal Alkhotaifi on 2/27/18.
//  Copyright © 2018 Faisal Alkhotaifi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    let greetingArray = ["Hi 🤚🏼", "Hello", "Hello, World!", "Hi again", "You come back :)", "Where have you been?"]
    var randomIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("--------: View did load in memory :)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        randomIndex = Int(arc4random_uniform(UInt32(greetingArray.count)))
        
        label.text = greetingArray[randomIndex]
        print("--------: View is about to be in veiw hierarchy :)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        print("--------: View is added in veiw hierarchy :)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        print("--------: View is about to be removed from veiw hierarchy :(")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        print("--------: View is removed from veiw hierarchy :(")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        print("--------: Memory warning is called :(")
    }


}

