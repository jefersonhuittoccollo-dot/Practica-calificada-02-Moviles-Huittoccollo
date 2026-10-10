//
//  CalculatorControllerViewController.swift
//  apple_lab08_pract02_UIKit
//
//  Created by Jeferson Huittoccollo on 6/10/26.
//

import UIKit

class CalculatorController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var num1TextField: UITextField!
    @IBOutlet weak var num2TextField: UITextField!
    @IBOutlet weak var operationButton: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    
    // Guardará la operación elegida
    var selectedOperation: String = "Addition (+)"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupOperationMenu()
    }
     
    private func setupOperationMenu() {
        // Acciones para el menú desplegable
        let addition = UIAction(title: "Addition (+)", state: .on) { [weak self] _ in
            self?.selectedOperation = "Addition (+)"
            self?.operationButton.setTitle("Addition (+)", for: .normal)
        }
        
        let subtraction = UIAction(title: "Subtraction (-)") { [weak self] _ in
            self?.selectedOperation = "Subtraction (-)"
            self?.operationButton.setTitle("Subtraction (-)", for: .normal)
        }
        
        let multiplication = UIAction(title: "Multiplication (×)") { [weak self] _ in
            self?.selectedOperation = "Multiplication (×)"
            self?.operationButton.setTitle("Multiplication (×)", for: .normal)
        }
        
        let division = UIAction(title: "Division (÷)") { [weak self] _ in
            self?.selectedOperation = "Division (÷)"
            self?.operationButton.setTitle("Division (÷)", for: .normal)
        }

        // Asignamos el UIMenu al botón
        operationButton.menu = UIMenu(title: "Select Operation", children: [addition, subtraction, multiplication, division])
        operationButton.showsMenuAsPrimaryAction = true
    }

    // MARK: - IBAction del botón Calculate
    @IBAction func calculatePressed(_ sender: UIButton) {
        guard let text1 = num1TextField.text, let n1 = Double(text1),
              let text2 = num2TextField.text, let n2 = Double(text2) else {
            return
        }

        var result: Double = 0
        switch selectedOperation {
        case "Addition (+)": result = n1 + n2
        case "Subtraction (-)": result = n1 - n2
        case "Multiplication (×)": result = n1 * n2
        case "Division (÷)": result = n2 != 0 ? n1 / n2 : 0
        default: break
        }

        let resultStr = result.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(result))" : "\(result)"

        // Buscar el ResultController en la 3ra pestaña (Índice 2)
        if let tabBarVC = self.tabBarController,
           let viewControllers = tabBarVC.viewControllers,
           viewControllers.count > 2 {
            
            var targetVC: ResultController?
            
            // Si la pestaña es directamente un ResultController
            if let resultVC = viewControllers[2] as? ResultController {
                targetVC = resultVC
            }
            // Si la pestaña está envuelta en un UINavigationController
            else if let navVC = viewControllers[2] as? UINavigationController,
                    let resultVC = navVC.topViewController as? ResultController {
                targetVC = resultVC
            }
            
            // Asignar los valores y cambiar de pestaña
            if let resultVC = targetVC {
                resultVC.operationStr = selectedOperation
                resultVC.num1Str = text1
                resultVC.num2Str = text2
                resultVC.resultStr = resultStr
                
                if resultVC.isViewLoaded {
                    resultVC.setupData()
                }
                
                tabBarVC.selectedIndex = 2
            }
        }
    }
}
