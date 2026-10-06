//
//  CalculatorControllerViewController.swift
//  apple_lab08_pract02_UIKit
//
//  Created by Jeferson Huittoccollo on 6/10/26.
//

import UIKit

class CalculatorController: UIViewController {

    // MARK: - Outlets (Campos de entrada y resultado)
    @IBOutlet weak var num1TextField: UITextField!
    @IBOutlet weak var num2TextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        num1TextField?.placeholder = "First Number"
        num1TextField?.keyboardType = .decimalPad
        
        num2TextField?.placeholder = "Second Number"
        num2TextField?.keyboardType = .decimalPad
        
        resultLabel?.text = "Result: "
    }
    
    // MARK: - IBActions para las Operaciones
    @IBAction func calculateSum(_ sender: UIButton) {
        performOperation { $0 + $1 }
    }
    
    @IBAction func calculateSubtract(_ sender: UIButton) {
        performOperation { $0 - $1 }
    }
    
    @IBAction func calculateMultiply(_ sender: UIButton) {
        performOperation { $0 * $1 }
    }
    
    @IBAction func calculateDivide(_ sender: UIButton) {
        performOperation { n1, n2 in
            guard n2 != 0 else {
                resultLabel.text = "Result: Error (Div/0)"
                return 0
            }
            return n1 / n2
        }
    }
    
    private func performOperation(_ operation: (Double, Double) -> Double) {
        guard let text1 = num1TextField.text, let n1 = Double(text1),
              let text2 = num2TextField.text, let n2 = Double(text2) else {
            resultLabel.text = "Result: Ingrese números válidos"
            return
        }
        
        let result = operation(n1, n2)
        // Muestra enteros sin decimales innecesarios (ej. 5 en lugar de 5.0)
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            resultLabel.text = "Result: \(Int(result))"
        } else {
            resultLabel.text = "Result: \(result)"
        }
    }
}
