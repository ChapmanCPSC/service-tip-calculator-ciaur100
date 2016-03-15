//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Stephen Ciauri on 3/14/16.
//  Copyright © 2016 stephenciauri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var ratingControl: UISegmentedControl!
    @IBOutlet weak var grandTotalLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    let formatter = NSNumberFormatter()
    var currentString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.numberStyle = .CurrencyStyle
        formatter.maximumFractionDigits = 2
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func ratingChanged(sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        var tipPercent = 0.0
        
        // Fancy range syntax doesn't save much time...
        switch selectedIndex{
        case 0,1,2:
            tipPercent = 0.1
        case 3,4:
            tipPercent = 0.13
        case 5,6:
            tipPercent = 0.15
        case 7,8:
            tipPercent = 0.2
        case 9:
            tipPercent = 0.25
        default:
            fatalError("Will never happen. Thanks dickhead.")
        }
        
        calculateTip(Double(tipPercent))
    }
    
    func calculateTip(percent: Double){
        if let text = priceTextField.text, subtotal = formatter.numberFromString(text){
            let tipAmount = Double(subtotal) * percent
            tipLabel.text = formatter.stringFromNumber(tipAmount)
            grandTotalLabel.text = formatter.stringFromNumber(tipAmount + Double(subtotal))
            
        }
        
    }
    
    // Text field formatting
    // Source: http://stackoverflow.com/questions/26569144/format-currency-in-textfield-in-swift-on-input
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool { // return NO to not change text
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            currentString += string
            formatCurrency(currentString)
        default:
            var currentStringArray = Array(currentString.characters)
            if string.characters.count == 0 && currentString.characters.count != 0 {
                currentStringArray.removeLast()
                currentString = ""
                for character in currentStringArray {
                    currentString += String(character)
                }
                formatCurrency(currentString)
            }
        }
        ratingControl.sendActionsForControlEvents(.ValueChanged)

        return false
    }
    
    func formatCurrency(string: String) {
        if let doubleFromString = Double(string){
            priceTextField.text = formatter.stringFromNumber(doubleFromString/100)
        }
    }



}

