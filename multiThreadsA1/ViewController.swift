//
//  ViewController.swift
//  multiThreadsA1
//
//  Created by ta on 9/5/17.
//  Copyright © 2017 ta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var maxIntTextField: UITextField!
    
    @IBOutlet weak var displayTableView: UITableView!
    
    @IBAction func submitButton(_ sender: UIButton) {
        let maxInt = Int(maxIntTextField.text!)
        
        
        //MARK: METHOD 1
        var prime = Array(repeating: true, count: maxInt!+1)
        
        var p = 2
        while(p*p <= maxInt!)
        {
            if prime[p] == true
            {
                for i in stride(from: p*2, to: maxInt!+1, by: p)
                {
                    prime[i] = false
                }
            }
            p = p + 1
        }
        
        for p in 2...maxInt!
        {
            if prime[p]
            {
                print(p)
            }
        }
        
        //MARK: METHOD 2
        /*
        var res = [Int]()
        
        for i in 3...maxInt!
        {
            //use break
        }
 */
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

