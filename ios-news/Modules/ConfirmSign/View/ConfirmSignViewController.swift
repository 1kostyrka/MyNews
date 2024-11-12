//
//  ConfirmSignConfirmSignViewController.swift
//  News
//
//  Created by Ivan Kostyrka on 09/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit

final class ConfirmSignViewController: UIViewController, ConfirmSignViewInput {

    var output: ConfirmSignViewOutput?

    @IBOutlet weak
    var codeTextField: OneTimeCodeTextField!
    
    @IBOutlet weak 
    var resendCodeButton: UIButton!
    
    @IBOutlet weak
    var continueButton: UIButton!
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output?.viewIsReady()
    }
    
    func configure() {
        
    }

    @IBAction 
    func didTapResendCodeButton(_ sender: UIButton) {
    }
    
    @IBAction
    func didTapContinueButton(_ sender: UIButton) {
    }
    // MARK: ConfirmSignViewInput

    func setupInitialState() {
    }

}
