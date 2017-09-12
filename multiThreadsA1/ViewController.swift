//
//  ViewController.swift
//  multiThreadsA1
//
//  Created by ta on 9/5/17.
//  Copyright © 2017 ta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var maxIntTextField: UITextField!
    
    @IBOutlet weak var displayTableView: UITableView!
    
    var resultArray = [Int]()

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
            
            for i in 2...Int(sqrt(Double(n)!))
            {
                if(A[i])
                {
                    for j in stride(from: i*i, to: Int(n)!, by: i)
                    {
                        A[j] = false
                    }
                }
            }
            
            resultArray = []
            
            for i in 2..<Int(n)! {
                if (A[i])
                {
                    //print(i)
                    resultArray.append(i)
                }
            }
            
            for item in resultArray{
                print(item)
            }
       print(resultArray.count)
        }
        else{
            //CHECK FOR 2 AND 3 AND 1 AND 0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "CELL") as! TableViewCell
        
        let prime = resultArray[indexPath.row]
        
        cell.dispLabel.text = String(prime)
        
        return cell
    }

}

