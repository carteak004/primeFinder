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
    var inactiveQueue: DispatchQueue!
    
    
    @IBOutlet weak var maxIntTextField: UITextField!
    
    @IBOutlet weak var displayTableView: UITableView!
    
    
    @IBOutlet weak var threadsLabel: UILabel!
    @IBOutlet weak var threadStepper: UIStepper!
    @IBAction func threadSelection(_ sender: UIStepper) {
        threadsLabel.text = Int(sender.value).description
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        let maxInt = Int(maxIntTextField.text!) ?? 2
        //primeArray = methodOne(maxInt: maxInt!)
       /*
        let queueX = DispatchQueue(label: "edu.niu.cs.queueX",
                                   qos: .userInitiated,
                                   attributes: [.concurrent, .initiallyInactive])
        
        if let queue = inactiveQueue
        {
            queue.activate()
        }
        
        inactiveQueue = queueX
        */
        
        concurrentQueues(maxInt: maxInt)
        
        /*
        let queueX = DispatchQueue(label: "edu.niu.cs.queueX")
        
        queueX.async {
            self.primeArray = self.methodOne(maxInt: maxInt)
            print(self.primeArray)
            //self.displayTableView.reloadData()
        }*/
        
        //print(primeArray)
        //print(maxInt)//method one is written outside queue
    }
    
    @IBOutlet weak var toggleViewButtonOutlet: UIButton!
    @IBAction func toggleViewButton(_ sender: UIButton) {
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
       /* let queueX = DispatchQueue(label: "edu.niu.cs.queueX",
                                   qos: .userInitiated,
                                   attributes: [.concurrent, .initiallyInactive])
        inactiveQueue = queueX*/
        
        let queueX = DispatchQueue(label: "edu.niu.cs.queueX")
        queueX.async {
            //self.primeArray = self.methodOne(maxInt: maxInt)
            //print(self.primeArray)
            self.primeArray = []
            var prime = Array(repeating: true, count: (maxInt+1)/2)
            
            var p = 2
            while(p*p <= maxInt/2)
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
                    self.primeArray.append(String(p))
                }
            }

        }
        
        queueX.async {
            for i in 4...7
            {
                print("\(i) thread 2")
            }
        }
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
}

