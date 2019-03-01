//
//  SignUpViewController.swift
//  XOGO
//
//  Created by siddharth on 28/02/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var reenterPasswordField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var companyNameField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var resellerCodeField: UITextField!
    @IBOutlet weak var resellerCodeButton: UIButton!
    @IBOutlet weak var userAgreementButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldDelegates()
        setButtonTickRender()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setNavigationBarTransparent()
    }
    

    
    @IBAction func resellerCodeButton(_ sender: UIButton) {
        setTick(sender: sender)
        makeReferCodeAlpha()
    }
    
    @IBAction func endUserAgreementFormButton(_ sender: Any) {
        openUrl(urlStr: "https://www.xogo.io/enduseragreement/")
    }
    
    @IBAction func userAgreementButton(_ sender: UIButton) {
        setTick(sender: sender)
    }
    
    
    @IBAction func bakButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if (reenterPasswordField.text == passwordField.text) && (userAgreementButton.isSelected == true){
            validate()
            showAlert(for: "Everything is good to go")
        }else if (reenterPasswordField.text == passwordField.text) && (userAgreementButton.isSelected == false){
            showAlert (for: "Please Accept User Agreement")
        }else {
            showAlert (for: "Passwords entered aren't the same")
        }
        
    }
    
}

extension SignUpViewController {
    
    func setButtonTickRender(){
        resellerCodeButton.setBackgroundImage(UIImage(named: "blank"), for: .normal)
        resellerCodeButton.setBackgroundImage(UIImage(named: "tick"), for: .selected)
        userAgreementButton.setBackgroundImage(UIImage(named: "blank"), for: .normal)
        userAgreementButton.setBackgroundImage(UIImage(named: "tick"), for: .selected)
    }
    
    func makeReferCodeAlpha(){
        if resellerCodeButton.isSelected == true {
            resellerCodeField.isUserInteractionEnabled = false
            resellerCodeField.alpha = 0.0
        } else {
            resellerCodeField.isUserInteractionEnabled = true
            resellerCodeField.alpha = 1.0
        }
    }
    
    func setTick(sender: UIButton){
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    func setNavigationBarTransparent(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .blue
    }
}


extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDelegates(){
        emailField.delegate = self
        passwordField.delegate = self
        reenterPasswordField.delegate = self
        firstNameField.delegate = self
        lastNameField.delegate = self
        companyNameField.delegate = self
        titleField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            reenterPasswordField.becomeFirstResponder()
        case reenterPasswordField:
            firstNameField.becomeFirstResponder()
        case firstNameField:
            lastNameField.becomeFirstResponder()
        case lastNameField:
            companyNameField.becomeFirstResponder()
        case companyNameField:
            titleField.becomeFirstResponder()
        default:
            titleField.becomeFirstResponder()
        }
        return true
    }
    
    
    
    func validate() {
        do {
            _ = try emailField.validatedText(validationType: ValidatorType.email)
            _ = try passwordField.validatedText(validationType: ValidatorType.password)
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
        if firstNameField.text == "" {
            showAlert(for: "Enter First Name")
        }
        if lastNameField.text == "" {
            showAlert(for: "Enter Last Name")
        }
        if companyNameField.text == "" {
            showAlert(for: "Enter Company Name")
        }
        if titleField.text == "" {
            showAlert(for: "Enter Title")
        }
    }
    
    func openUrl(urlStr:String!) {
        let urlString = NSURL(string:urlStr)! as URL
        UIApplication.shared.open(urlString, options: [:], completionHandler: nil)
    }
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
