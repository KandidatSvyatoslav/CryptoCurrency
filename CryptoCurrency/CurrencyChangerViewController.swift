//
//  CurrencyChangerViewController.swift
//  CryptoCurrency
//
//  Created by Admin on 28.07.17.
//  Copyright © 2017 Svt. All rights reserved.
//

import UIKit

class CurrencyChangerViewController: UIViewController, UITextFieldDelegate {

    var currency = Currency()
    
    @IBOutlet weak var inputValueTextField: UITextField!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var outputPriceLabel: UILabel!
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()
        self.inputValueTextField.delegate = self
        inputValueTextField.text = "0"
        outputPriceLabel.text = "0"
        inputLabel.text = currency.name
        outputLabel.text = "Dollars"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var dollars = "Dollars"
    
    @IBAction func pressedCalc(_ sender: Any) {
        //Нажатие на кнопку Calculate
        var usd  = Double(currency.priceUsd)!
        if inputLabel.text == currency.name {
            outputPriceLabel.text = String(Double(inputValueTextField.text!)! * usd)
        }
        if inputLabel.text == dollars {
            outputPriceLabel.text = String(Double(inputValueTextField.text!)! / usd)
        }
    }

    @IBAction func Transfer(_ sender: Any) {
       //Кнопка смены валюты которую обмениваешь
        if inputLabel.text == dollars {
            inputLabel.text = currency.name
            outputLabel.text = dollars
        } else {
            inputLabel.text = dollars
            outputLabel.text = currency.name
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Ввод только символов из диапазона "0123456789."
        let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..<
            string.endIndex) == nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Скрыть клавиатуру
        if (touches.first) != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        //Не скрывать Nav.Controller
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
