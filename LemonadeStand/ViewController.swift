//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Ryan Jones on 5/25/15.
//  Copyright (c) 2015 Ryan Jones. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var inventoryLemonsLabel: UILabel!
    @IBOutlet weak var inventoryIceCubesLabel: UILabel!
    
    @IBOutlet weak var purchaseLemonsLabel: UILabel!
    @IBOutlet weak var purchaseIceCubesLabel: UILabel!
    @IBOutlet weak var mixLemonsLabel: UILabel!
    @IBOutlet weak var mixIceCubesLabel: UILabel!
    
    var supplies = Supplies(aMoney: 10, aLemons: 1, aIceCubes: 1)
    let price = Price()
    
    var lemonsToPurchase = 0
    var iceCubeToPurchase = 0
    var lemonsToMix = 0
    var iceCubesToMix = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateMainView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func purchaseLemonsPlusButtonPressed(sender: UIButton) {
        if supplies.money >= price.lemon {
            lemonsToPurchase += 1
            supplies.money -= price.lemon
            supplies.lemons += 1
            updateMainView()
        }
        else {
            showAlertWithText(message: "You don't have enough money")
        }
    }
    @IBAction func purchaseLemonsMinusButtonPressed(sender: UIButton) {
        if lemonsToPurchase > 0 {
            lemonsToPurchase -= 1
            supplies.money += price.lemon
            supplies.lemons -= 1
            updateMainView()
        }
        else {
            showAlertWithText(message: "You don't have a lemon to return")
        }
    }
    @IBAction func purchaseIceCubesPlusButtonPressed(sender: UIButton) {
        if supplies.money >= price.iceCube {
            iceCubeToPurchase += 1
            supplies.money -= price.iceCube
            supplies.iceCubes += 1
            updateMainView()
        }
        else {
            showAlertWithText(message: "You don't have enough money")
        }
    }
    @IBAction func PurchaseIceCubesMinusButtonPressed(sender: UIButton) {
        if iceCubeToPurchase > 0 {
            iceCubeToPurchase -= 1
            supplies.money += price.iceCube
            supplies.iceCubes -= 1
            updateMainView()
        }
        else {
            showAlertWithText(message: "You don't have an Ice Cube to return")
        }
    }
    @IBAction func mixLemonsPlusButtonPressed(sender: UIButton) {
        if supplies.lemons > 0 {
            lemonsToPurchase = 0
            supplies.lemons -= 1
            lemonsToMix += 1
            updateMainView()
        }
        else {
            showAlertWithText(header: "Warning", message: "You don't have enough inventory")
        }
    }
    @IBAction func mixLemonsMinusButtonPressed(sender: UIButton) {
        if lemonsToMix > 0 {
            lemonsToMix -= 1
            supplies.lemons += 1
            lemonsToPurchase = 0
            updateMainView()
        }
        else {
            showAlertWithText(header: "Warning", message: "Nothing to return")
        }
    }
    @IBAction func mixIceCubesPlusButtonPressed(sender: UIButton) {
        if supplies.iceCubes > 0 {
            iceCubesToMix += 1
            supplies.iceCubes -= 1
            iceCubeToPurchase = 0
            updateMainView()
        }
        else {
            showAlertWithText(header: "Warning", message: "You don't have enough inventory")
        }
    }
    @IBAction func mixIceCubesMinusButtonPressed(sender: UIButton) {
        if iceCubesToMix > 0 {
            iceCubesToMix -= 1
            iceCubeToPurchase = 0
            supplies.iceCubes += 1
            updateMainView()
        }
        else {
            showAlertWithText(header: "Warning", message: "Nothing to return")
        }
    }

    @IBAction func startDayButtonPressed(sender: UIButton) {
        var lemonadeRatio = 0.0
        let customers = Int(arc4random_uniform(UInt32(11)))
        println("\(customers) Customers")
        
        if lemonsToMix == 0 || iceCubesToMix == 0 {
            showAlertWithText(message: "You need to add atleast 1 Lemon and 1 Ice Cube")
        }
        else {
            var lemonadeRatio = Double(lemonsToMix) / Double(iceCubesToMix)
        }
        for x in 0...customers {
            let preference = Double(arc4random_uniform(UInt32(101))) / 100
            if preference < 0.4 && lemonadeRatio > 1 {
                supplies.money += 1
                println("Paid")
            }
            else if preference > 0.6 && lemonadeRatio < 1 {
                supplies.money += 1
                println("Paid")
            }
            else if preference <= 0.6 && preference >= 0.4 && lemonadeRatio == 1 {
                supplies.money += 1
                println("Paid")
            }
            else {
                println("else statment evaluating")
            }
            lemonsToPurchase = 0
            iceCubeToPurchase = 0
            lemonsToMix = 0
            iceCubesToMix = 0
            updateMainView()
        }
    }
    
    
    // Helper Functions
    
    func updateMainView() {
        cashLabel.text = "\(supplies.money)"
        inventoryLemonsLabel.text = "\(supplies.lemons)"
        inventoryIceCubesLabel.text = "\(supplies.iceCubes)"
        purchaseLemonsLabel.text = "\(lemonsToPurchase)"
        purchaseIceCubesLabel.text = "\(iceCubeToPurchase)"
        mixLemonsLabel.text = "\(lemonsToMix)"
        mixIceCubesLabel.text = "\(iceCubesToMix)"
    }
    
    func showAlertWithText (header: String = "Warning", message : String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

