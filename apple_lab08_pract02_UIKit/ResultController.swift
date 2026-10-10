//
//  ResultController.swift
//  apple_lab08_pract02_UIKit
//
//  Created by Jeferson Huittoccollo Sucapuca on 10/10/26.
//

import UIKit

class ResultController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var num1Label: UILabel!
    @IBOutlet weak var num2Label: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var newCalculationButton: UIButton!
    
    // Variables para recibir los datos de la calculadora
    var operationStr: String = ""
    var num1Str: String = ""
    var num2Str: String = ""
    var resultStr: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    
    func setupData() {
        operationLabel?.text = operationStr.isEmpty ? "—" : operationStr
        num1Label?.text = num1Str.isEmpty ? "—" : num1Str
        num2Label?.text = num2Str.isEmpty ? "—" : num2Str
        resultLabel?.text = resultStr.isEmpty ? "0" : resultStr
    }
    
    private func setupUI() {
        newCalculationButton?.layer.borderWidth = 2
        newCalculationButton?.layer.borderColor = UIColor.systemBlue.cgColor
        newCalculationButton?.layer.cornerRadius = 20
        newCalculationButton?.layer.masksToBounds = true
    }
    
    // MARK: - Actions
    @IBAction func sharePressed(_ sender: UIButton) {
        guard !resultStr.isEmpty else { return }
        let textToShare = "Cálculo realizado: \(operationStr)\n\(num1Str) y \(num2Str) = \(resultStr)"
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func newCalculationPressed(_ sender: UIButton) {
        // Redirige de vuelta a la pestaña de Calculator (Índice 1)
        if let tabBarVC = self.tabBarController {
            tabBarVC.selectedIndex = 1
        }
    }
}
