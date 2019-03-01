//
//  LoginViewController.swift
//  XOGO
//
//  Created by siddharth on 28/02/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func quickStartGuideButton(_ sender: Any) {
        openUrl(urlStr: "https://www.xogo.io/gettingstarted")
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        openUrl(urlStr: "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwjz2b7J7t3gAhXKuI8KHcpKAc0QjRx6BAgBEAU&url=https%3A%2F%2Fwww.xogo.io%2F&psig=AOvVaw3PWql4Ny6lXbM8i5EiXPQe&ust=1551423896264636")
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if (emailField.text != "") && (passwordField.text != "") {
            validate()
            performSegue(withIdentifier: "loginSuccessSegue", sender: nil)
        }else {
            showAlert(for: "Login Failed")
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "showSignUpSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {
        case "loginSuccessSegue":
            let dest = segue.destination as! UINavigationController
            let targetController = dest.topViewController as! HomeViewController
            targetController.emailPassedFromLogin = emailField.text
            
        case "showSignUpSegue":
            let dest = segue.destination as! UINavigationController
            let targetController = dest.topViewController as! SignUpViewController

        default: break
        }
        
    }
    
}

extension LoginViewController {
    
    func openUrl(urlStr:String!) {
        let urlString = NSURL(string:urlStr)! as URL
        UIApplication.shared.open(urlString, options: [:], completionHandler: nil)
    }
    
    func validate() {
        do {
            _ = try emailField.validatedText(validationType: ValidatorType.email)
            _ = try passwordField.validatedText(validationType: ValidatorType.password)
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
    }
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

