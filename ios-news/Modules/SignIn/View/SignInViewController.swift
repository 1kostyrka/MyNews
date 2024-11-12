//
//  SignInSignInViewController.swift
//  News
//
//  Created by Ivan Kostyrka on 09/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController, SignInViewInput {
    
    var output: SignInViewOutput?
    
    @IBOutlet weak
    var emailTextField: UITextField!
    @IBOutlet weak
    var passwordTextField: UITextField!
    
    @IBOutlet weak
    var signInButton: UIButton!
    
    @IBOutlet weak
    var appleView: UIView!
    @IBOutlet weak
    var googleView: UIView!
    
    
    @IBOutlet weak
    var forgetPasswordButton: UIButton!
    @IBOutlet weak
    var signUpButton: UIButton!
    
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output?.viewIsReady()
    }
    
    func configure() {
        signInButton.layer.cornerRadius = 10
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
        passwordTextField.returnKeyType = .done
        emailTextField.returnKeyType = .done
    }
    
    @IBAction
    func didTapSignInButton(_ sender: UIButton) {
        performSignIn()
    }
    
    
    @IBAction
    func didTapForgetButton(_ sender: UIButton) {
    }
    
    @IBAction
    func didTapSignUpButton(_ sender: UIButton) {
        output?.didOpenRegister()
    }
    
    func performSignIn() {
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if email == "test" && password == "password" {
            navigateToMain()
        } else {
            
            let alert = UIAlertController(title: "Помилка", message: "Неправильний логін або пароль", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    func navigateToMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = rootViewController
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
    
    
    // MARK: SignInViewInput
    
    func setupInitialState() {
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
