//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Kushal Jogi on 3/9/17.
//  Copyright © 2017 kushal. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var defaultTip: UISegmentedControl!

    @IBOutlet weak var numberPeople: UITextField!
    @IBOutlet weak var peopleStepper: UIStepper!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let defaults = UserDefaults.standard
        let defaultTipSegmentIndex = defaults.integer(forKey: "default_tip_index")
        print("Default Tip Index: \(defaultTipSegmentIndex)")
        defaultTip.selectedSegmentIndex = defaultTipSegmentIndex
        let defaultNumberPeople = defaults.double(forKey: "default_number_people")
        peopleStepper.value = Double(defaultNumberPeople)
        
        
        numberPeople.text = String(peopleStepper.value)

    }

    override func viewWillDisappear(_ animated: Bool) {
        updateDefaultTip()
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func defaultTipChanged(_ sender: Any) {
        updateDefaultTip()
    }

    func updateDefaultTip(){
        let defaults = UserDefaults.standard
        defaults.set(defaultTip.selectedSegmentIndex, forKey: "default_tip_index")
        defaults.set(peopleStepper.value, forKey: "default_number_people")
        defaults.synchronize()
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        numberPeople.text = String(peopleStepper.value)
    }
    
    @IBAction func personChanged(_ sender: Any) {
        peopleStepper.value = Double (numberPeople.text!) ?? 1
    }
}
