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
    
    
    @IBOutlet weak var maxIntTextField: UITextField!
    
    @IBOutlet weak var displayTableView: UITableView!
    
    @IBAction func methodSelector(_ sender: UISegmentedControl) {
    }
    
    @IBOutlet weak var threadsLabel: UILabel!
    @IBOutlet weak var threadStepper: UIStepper!
    @IBAction func threadSelection(_ sender: UIStepper) {
        threadsLabel.text = Int(sender.value).description
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        let maxInt = Int(maxIntTextField.text!)
        primeArray = methodOne(maxInt: maxInt!)
    }
    
    @IBOutlet weak var toggleViewButtonOutlet: UIButton!
    @IBAction func toggleViewButton(_ sender: UIButton) {
        if(toggleViewButtonOutlet.currentTitle! == "Show")
        {
            toggleViewButtonOutlet.setTitle("Hide", for: .normal)
            displayTableView.isHidden = false
        }
        else if(toggleViewButtonOutlet.currentTitle! == "Hide")
        {
            toggleViewButtonOutlet.setTitle("Show", for: .normal)
            displayTableView.isHidden = true
        }
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        primeArray = []
    }
    
    //MARK: METHOD 1
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
        print(primeArray)
        return primeArray
    }
    
    //MARK: METHOD 2
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        primeArray = ["one","two"]
        displayTableView.reloadData()
        print(primeArray)
        
        displayTableView.isHidden = true
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
        //print(primeArray.count)
        return primeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = displayTableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        
        //let primeResult = primeArray[indexPath.row]
        
        cell.textLabel?.text = self.primeArray[indexPath.row]
        
        return cell
    }
}

