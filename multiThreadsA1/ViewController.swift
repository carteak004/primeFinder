//
//  ViewController.swift
//  multiThreadsA1
//
//  Created by Kartheek Chintalapati on 9/5/17.
//  Copyright © 2017 Kartheek Chintalapati. All rights reserved.
//
/********************************************************************************************
 Purpose: To implement GCD and find the prime numbers less than or equal to a given number.
 To perform various tasks on the foreground while background is working on computing primes.
 ********************************************************************************************/

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Variable declaration
    var primeArray: [String] = []
    var primeBool: [Bool] = []
    var inactiveQueue: DispatchQueue!
    
    //MARK: Outlets and Actions declaration
    @IBOutlet weak var maxIntTextField: UITextField!
    
    @IBOutlet weak var displayTableView: UITableView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeElapsedLabel: UILabel!
    
    @IBOutlet weak var threadsLabel: UILabel!
    @IBOutlet weak var threadStepper: UIStepper!
    @IBAction func threadSelection(_ sender: UIStepper) {
        threadsLabel.text = Int(sender.value).description
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        view.endEditing(true)
        let maxVal = Int(maxIntTextField.text!) ?? 2 //Assigns a default value of 2 if Start is pressed without any entry.
        
        if (maxVal >= 2 && maxVal <= 10000) //Checks for limit 2-10000. If any other value is entered, will show a dialog box.
        {
            concurrentQueues(maxInt: maxVal) //Implements GCD
        }
        else
        {
            displayAlert() //Shows an alert dialog box
            maxIntTextField.text = ""
        }
    }
    
    @IBOutlet weak var toggleViewButtonOutlet: UIButton!
    @IBAction func toggleViewButton(_ sender: UIButton) { //Show button
        view.endEditing(true)
        displayTableView.reloadData()
    }
    
    @IBAction func clearButton(_ sender: UIButton) {    //clears maxInt field and data from the table.
        view.endEditing(true)
        primeArray = []
        maxIntTextField.text = ""
        displayTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.isHidden = true
        timeElapsedLabel.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: User defined functions
    
    //MARK: Dialog Box
    func displayAlert()
    {
        let alert = UIAlertController(title: "Really!", message: "Did you check the LIMITS!!!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: Queueing
    func concurrentQueues(maxInt : Int)
    {
        let start = NSDate()
        
        primeArray = []
        
        primeBool = Array(repeating: true, count: maxInt+1)
        
        let numThreads = Int(threadsLabel.text!)!
        
        var startVal: Int, endVal: Int
        
        for i in stride(from: 1, through: numThreads, by: 1)
        {
            
            startVal = (((i-1)*maxInt)/numThreads)
            endVal = (i*maxInt)/numThreads
            
            let queueX = DispatchQueue(label: "edu.niu.cs.queueX")
            
            queueX.sync {
                self.primeArray = self.methodOne(startVal: startVal, endVal: endVal, maxInt: maxInt, thread: i)
            }
            
        }
        
        let end = NSDate()
        let timeInterval = end.timeIntervalSince(start as Date) //calculates time in seconds
        
        timeElapsedLabel.text = "\(((Double(timeInterval)*1000000).rounded())/1000) milliseconds" //Displays time in ms
        
        timeLabel.isHidden = false
        timeElapsedLabel.isHidden = false
        
    }
 
    //MARK: SOE
    func methodOne(startVal: Int, endVal: Int, maxInt: Int, thread: Int) -> Array<String>
    {
        var p = 2, start = startVal
        
        while(p*p <= maxInt)
        {
            if(primeBool[p] == true)
            {
                if(endVal == maxInt/3 || endVal == maxInt/2 || endVal == maxInt/4)
                {
                    start = 2*p
                }
                else
                {
                    for i in start...endVal
                    {
                        if i%p == 0
                        {
                            start = i
                            break;
                        }
                    }
                }
                
                for j in stride(from: start, through: endVal, by: p)
                {
                    primeBool[j] = false
                }
            }
            
            p = p+1
        }
        
        for k in startVal...endVal
        {
            if primeBool[k] && k != 1 && k != 0
            {
                primeArray.append("Prime \(k) - Thread \(thread)")
            }
        }
        return primeArray
    }
    
    
    
    //MARK: Table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return primeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = displayTableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! TableViewCell
        let primeResult = primeArray[indexPath.row]
        cell.dataViewLabel.text = primeResult
        
        return cell
    }
    
    //MARK: Delegate Methods
    
    //This function dismisses the keyboard when tapped outside the field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

