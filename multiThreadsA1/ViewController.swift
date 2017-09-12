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
        /*
         var A = Array(repeating: true, count: n!)
         print(A)
         
         for i in 2...Int(sqrt(Double(n!)))
         {
         for j in 1...(n!-1)
         {
         if j%i == 0
         {
         A[j] = false
         }
         }
         }
         
         for i in 2...(n!-1)
         {
         if A[i]
         {
         print(i)
         }
         }
         */
        
        
        //MARK: METHOD 2
        for i in 3...maxInt!
        {
            //use break
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

