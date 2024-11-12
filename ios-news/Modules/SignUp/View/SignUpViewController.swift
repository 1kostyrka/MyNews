//
//  SignUpSignUpViewController.swift
//  News
//
//  Created by Ivan Kostyrka on 09/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import M13Checkbox

final class SignUpViewController: UIViewController, SignUpViewInput {

    var output: SignUpViewOutput?

    @IBOutlet weak
    var nameTextField: UITextField!
    @IBOutlet weak
    var surnameTextField: UITextField!
    @IBOutlet weak
    var emailTextField: UITextField!
    @IBOutlet weak
    var passwordTextField: UITextField!

    
    @IBOutlet weak 
    var continueButton: UIButton!
    
    @IBOutlet weak
    var acceptPrivacyCheckbox: M13Checkbox!
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output?.viewIsReady()
    }
    
    func configure() {
        continueButton.layer.cornerRadius = 10
        
        acceptPrivacyCheckbox.stateChangeAnimation = .fade(.fill)
        acceptPrivacyCheckbox.boxType = .square
    }
    
    
    
    @IBAction
    func didTapContinueButton(_ sender: UIButton) {
    }
    

    // MARK: SignUpViewInput

    func setupInitialState() {
    }

}
