//
//  ViewController.swift
//  CalculatorStack
//
//  Created by Roman Kniukh on 18.01.21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Varibles
    var numberFromScreen: Double = 0
    var firstNumber: Double = 0
    var operation: Int = 0
    var mathSign: Bool = false
    
    
    // MARK: - Outlets
    @IBOutlet var numeralButtonCollection: [UIButton]!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet var operationButtonCollection: [UIButton]!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.numeralButtonCollection.enumerated().forEach {
            $1.setTitle("\($0)", for: .normal)
            $1.titleLabel?.font = .systemFont(ofSize: 30)
            $1.layer.cornerRadius = $1.bounds.width / 2
        }
        
        self.operationButtonCollection.enumerated().forEach {
            $1.layer.cornerRadius = $1.bounds.width / 2
        }
    }
    
    // MARK: - Actions
    @IBAction func digits(_ sender: UIButton) {
        if mathSign == true {
            resultLabel.text = String(sender.tag)
            mathSign = false
        }
        else {
            resultLabel.text = resultLabel.text! + String(sender.tag)
        }
        
        numberFromScreen = Double(resultLabel.text!)!
    }
    
    @IBAction func operationButton(_ sender: UIButton) {
        if resultLabel.text != nil && sender.tag != 10 && sender.tag != 11 {
            firstNumber = Double(resultLabel.text!)!
            
            if sender.tag == 15 { // сложение
                resultLabel.text = "+"
            }
            else if sender.tag == 12 { // деление
                resultLabel.text = "/"
            }
            else if sender.tag == 13 { // умножение
                resultLabel.text = "*"
            }
            else if sender.tag == 14 { // вычитание
                resultLabel.text = "-"
            }
            
            operation = sender.tag
            mathSign = true
        }
        else if sender.tag == 11 {
            if operation == 12 {
                self.setAmount(number: Float(firstNumber / numberFromScreen))
            }
            else if operation == 13 {
                self.setAmount(number: Float(firstNumber * numberFromScreen))
            }
            else if operation == 14 {
                self.setAmount(number: Float(firstNumber - numberFromScreen))
            }
            else if operation == 15 {
                self.setAmount(number: Float(firstNumber + numberFromScreen))
            }
        }
        else if sender.tag == 10 {
            resultLabel.text = ""
            numberFromScreen = 0
            firstNumber = 0
            operation = 0
        }
    }
    
    
    
    // MARK: - Methods
    private func setAmount(number: Float) {
        let modifiedFloat = modf(number)
        let mainPart = Int(modifiedFloat.0)
        let decimalPart = Int(modifiedFloat.1 * 10)
        
        // Main part
        var mainAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40)]
        mainAttributes[NSAttributedString.Key.foregroundColor] = UIColor.red

        // Decimal part
        let decimalAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35.0),
            NSAttributedString.Key.foregroundColor: UIColor.blue]

        let amountAttributedText = NSMutableAttributedString(string: String(mainPart),
                                                             attributes: mainAttributes)
        
        guard modifiedFloat.1 == 0.0 else {
            amountAttributedText.append(NSAttributedString(string: ",", attributes: mainAttributes))
            amountAttributedText.append(NSAttributedString(string: String(decimalPart),
                                                           attributes: decimalAttributes))
            return self.resultLabel.attributedText = amountAttributedText
        }
        
        self.resultLabel.attributedText = amountAttributedText
    }
}

