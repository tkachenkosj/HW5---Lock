//
//  ViewController.swift
//  HW5 - Lock
//
//  Created by Сергей Ткаченко on 06.10.2020.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var forgotUserNameButton: UIButton!
    @IBOutlet var forgotPasswordButton: UIButton!
    
    private let userName = "matrix"
    private let password = "rabbit"
    private var attemptsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forgotUserNameButton.isHidden = true
        forgotPasswordButton.isHidden = true
        
    }

    @IBAction func pressedLogInButton() {
        
        guard let userNameText = userNameTextField.text?.lowercased() else { return }
        guard let passwordText = passwordTextField.text?.lowercased() else { return }
        
        if userNameText == userName && passwordText == password {
            performSegue(withIdentifier: "goToUnlockScreen", sender: nil)
            userNameTextField.text = nil
            passwordTextField.text = nil
        } else if userNameText == "" {
            showAlert(title: "Reminder:", message: "Enter your username!")
        } else if passwordText == "" {
            showAlert(title: "Reminder:", message: "Enter your password!")
        } else if attemptsCount == 2 {
            showAlert(title: "Failure!", message: "Invalid username / password combination! \nUse the tips below.")
            forgotUserNameButton.isHidden = false
            forgotPasswordButton.isHidden = false
        } else {
            attemptsCount += 1
            showAlert(title: "Failure!", message: "Invalid username / password combination!")
            userNameTextField.text = nil
            passwordTextField.text = nil
        }
    }
    
    @IBAction func pressedForgotUserNameButton() {
        showAlert(title: "User name:", message: "Knock, knock, Neo! (User name) has you...")
    }
    
    @IBAction func pressedForgotPasswordButton() {
        showAlert(title: "Password", message: "Follow the white (Password)")
    }
    
    @IBAction func unvindSegue(_ sender: UIStoryboardSegue) {}
    
}

extension LogInViewController: UITextFieldDelegate {
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else {
            pressedLogInButton()
        }
        return true
    }
}

