//
//  ViewController.swift
//  multiThreadsA1
//
//  Created by ta on 9/5/17.
//  Copyright © 2017 ta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var primeArray: [String] = []
    var primeBool: [Bool] = []
    var inactiveQueue: DispatchQueue!
    
    
    @IBOutlet weak var maxIntTextField: UITextField!
    
    @IBOutlet weak var displayTableView: UITableView!
    
    @IBOutlet weak var timeElapsedLabel: UILabel!
    
    @IBOutlet weak var threadsLabel: UILabel!
    @IBOutlet weak var threadStepper: UIStepper!
    @IBAction func threadSelection(_ sender: UIStepper) {
        threadsLabel.text = Int(sender.value).description
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        view.endEditing(true)
        let maxVal = Int(maxIntTextField.text!) ?? 2
        if (maxVal >= 2 && maxVal <= 10000)
        {
            concurrentQueues(maxInt: maxVal)
        }
        else
        {
            let alert = UIAlertController(title: "Really!", message: "Did you check the LIMITS!!!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            maxIntTextField.text = ""
        }
       
    }
    
    @IBOutlet weak var toggleViewButtonOutlet: UIButton!
    @IBAction func toggleViewButton(_ sender: UIButton) {
        view.endEditing(true)
        /*
        if(toggleViewButtonOutlet.currentTitle! == "Show")
        {
            toggleViewButtonOutlet.setTitle("Hide", for: .normal)
            displayTableView.isHidden = false
        }
        else if(toggleViewButtonOutlet.currentTitle! == "Hide")
        {
            toggleViewButtonOutlet.setTitle("Show", for: .normal)
            displayTableView.isHidden = true
        }*/
        displayTableView.reloadData()
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        view.endEditing(true)
        primeArray = []
        maxIntTextField.text = ""
        displayTableView.reloadData()
        //print(primeArray)
    }
    
    //MARK: METHOD 1
    /*
    func methodOne(maxInt: Int) -> Array<String>
    {
        primeArray = []
        var prime = Array(repeating: true, count: maxInt+1)
        
        var p = 2
        while(p*p <= maxInt)
        {
            if prime[p] == true
            {
                for i in stride(from: p*2, to: maxInt+1, by: p)
                {
                    prime[i] = false
                }
            }
            p = p + 1
        }
        
        for p in 2...maxInt
        {
            if prime[p]
            {
                primeArray.append(String(p))
            }
        }
        //print(primeArray)
        return primeArray
    }*/
    //func methodOne(maxInt: Int , num: Int, thread: Int, arr: [(Bool)]) -> (Array<String>, Array<Bool>)
    
    
    
    func methodOne(startVal: Int , endVal: Int, maxInt: Int, thread: Int) -> Array<String>
    {
        
        var p=2
        while(p*p <= maxInt)
        {
            if primeBool[p] == true
            {
                for i in stride(from: startVal, to: endVal, by: p)
                {
                    primeBool[i] = false
                }
            }
            p = p + 1
        }
        
        for p in 2...endVal
        {
            if primeBool[p]
            {
                primeArray.append("\(p) - Thread \(thread)")
            }
        }
        //print(primeArray)
        return primeArray
    }
    

    
 
    //MARK: METHOD 2
    /*
    func methodTwo(maxInt: Int) -> Array<String>
    {
        primeArray = []
        for x in 2...maxInt
        {
            var p = true
            for y in 2...Int(sqrt(Double(maxInt)))
            {
                if (x > y)
                {
                    if (x % y == 0)
                    {
                        p = false
                        break
                    }
                }
            }
            
            if p == true
            {
                primeArray.append(String(x))
            }
        }
        
        return primeArray
    }

    */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: Queueing
    func concurrentQueues(maxInt : Int)
    {
        let start = NSDate()
        
        primeArray = []
        primeBool = Array(repeating: true, count: maxInt+1)
        let numThreads = Int(threadsLabel.text!)!
        var firstTime = true
        var startVal: Int, endVal: Int
        for i in stride(from: 1, through: numThreads, by: 1)
        {
            let queueX = DispatchQueue(label: "edu.niu.cs.queueX")
            
            if (firstTime)
            {
                startVal = 2
                firstTime = false
            }
            else
            {
                startVal = ((i-1)*maxInt)/numThreads
            }
            
            endVal = (i*maxInt)/numThreads
            
            queueX.async {
                self.primeArray = self.methodOne(startVal: startVal, endVal: endVal, maxInt: maxInt, thread: i)
            }
        }
        
        let end = NSDate()
        let timeInterval = end.timeIntervalSince(start as Date)
        
        timeElapsedLabel.text = "\(((Double(timeInterval)*1000000).rounded())/1000) milliseconds"
        //print(((Double(timeInterval)*1000000).rounded())/1000)
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
    
    //This function dismisses the keyboard when the user presses the return key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        maxIntTextField.resignFirstResponder()
        
        return true
    }
}

