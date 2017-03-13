//
//  ViewController.swift
//  TipCalc
//
//  Created by Kushal Jogi on 3/4/17.
//  Copyright © 2017 kushal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billValue: UITextField!
    @IBOutlet weak var tipValue: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    
    @IBOutlet weak var selectedTip: UISegmentedControl!
    
    @IBOutlet weak var customTip: UITextField!
    
    @IBOutlet weak var perPerson: UILabel!
    let tipPercentage = [0.15,0.20,0.25]
    var tip = 0.00
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let defaultTipSegmentIndex = defaults.integer(forKey: "default_tip_index")
        selectedTip.selectedSegmentIndex = defaultTipSegmentIndex
        
        
        updateValues()
        
        super.viewWillAppear(animated)
        print("view will appear")
     //   billValue.becomeFirstResponder()
    
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
 
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        updateValues()
        
    }
    
    func updateValues(){
        let bill = Double(billValue.text!) ?? 0
        var total = 0.0
        if(selectedTip.selectedSegmentIndex == selectedTip.numberOfSegments - 1){
            customTip.isHidden = false
            customTip.isEnabled = true
            customTip.becomeFirstResponder()
            tip = Double(customTip.text!) ?? 0
            tipValue.text = String(format: "$%.2f", tip)
            total = bill + tip;
            totalValue.text = String(format: "$%.2f", total)
        }
        
        else{
             customTip.isHidden = true
             customTip.isEnabled = false
             tip = tipPercentage[selectedTip.selectedSegmentIndex]
            
            tipValue.text = String(format: "$%.2f", tip*bill)
            total = tip*bill + bill
            totalValue.text = String(format: "$%.2f", total)

        }
        
        let defaults = UserDefaults.standard
        var numberPeople = defaults.double(forKey: "default_number_people") 
        if(numberPeople == 0.0){
            numberPeople = 1.0
        }
        let perPersonValue = total / (numberPeople)
        perPerson.text = String(format: "$%.2f", perPersonValue)
        
        
    }

}

