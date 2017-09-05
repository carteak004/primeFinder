//
//  ViewController.swift
//  multiThreadsA1
//
//  Created by ta on 9/5/17.
//  Copyright © 2017 ta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var maxInt: UITextField!
    
    @IBOutlet weak var displayTableView: UITableView!

    @IBAction func submitButton(_ sender: UIButton) {
        let n = Int(maxInt.text!)
        
        // let sqrtn = sqrt(Double(n!))
        
        var maxIntArray = Array(repeating: true, count: Int(n!))
        
        for i in 2..<n!{
            if (i%n!==0) {
                maxIntArray[i] = false
            }
        }
        
        for item in maxIntArray {
            
                print(item)
            
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

